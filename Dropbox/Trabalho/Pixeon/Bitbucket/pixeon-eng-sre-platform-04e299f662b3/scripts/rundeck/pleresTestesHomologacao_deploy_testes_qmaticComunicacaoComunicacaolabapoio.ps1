#variables
$apiUrl = 'https://ci.appveyor.com/api' #base url of appveyor api
$token = '8no6s0gut6osr3ls2n4f' #api token, you can generate in profile section
$headers = @{
  "Authorization" = "Bearer $token"
  "Content-type" = "application/json"
}
$accountName = 'Digitalmed' #name of appveyor account
$project = 'pleres-net-25a64' #project name
$build = '@option.build@' #Build Appveyor
if ("@option.ComunicacaoLabApoio@" -eq "false") {
    $artifactslist = @('SrvWin.IntegracaoQmatic','SrvWin.Comunicacao')
} else {
    $artifactslist = @('SrvWin.IntegracaoQmatic','SrvWin.Comunicacao','SrvWin.ComunicacaoLaboratorioApoio') #list of all artifacts that you want to download
}
if ("@option.ComunicacaoLabApoio@" -eq "false") {
    $servicesmatchlist = @('integracaoqmatic','comunicacao[^l]')
} else {
    $servicesmatchlist = @('integracaoqmatic','comunicacao','comunicacaolaboratorioapoio')
}
$downloadfolder = 'z:\temp\' #download folder location
$pleresnetpath = "D:\App\PleresNet.@option.Ambiente@\" #PleresNet path
$itenstoremovelist = @('z:\temp\SrvWin.Comunicacao.zip','z:\temp\SrvWin.ComunicacaoLaboratorioApoio.zip','z:\temp\SrvWin.IntegracaoQmatic.zip','z:\temp\SrvWin.Comunicacao','z:\temp\SrvWin.ComunicacaoLaboratorioApoio','z:\temp\SrvWin.IntegracaoQmatic')
$excluded_files = @("SrvWin.IntegracaoQmatic.exe.config", "SrvWin.Comunicacao.exe.config", "Digitalmed.SrvWin.ComunicacaoLaboratorioApoio.exe.config") #files to exclude in copying to services folders

Write-Host "Ambiente: @option.Ambiente@"
Write-Host "Fazer deploy do ComunicacaoLaboratorioApoio: @option.ComunicacaoLabApoio@"
Write-Host "Build: @option.build@"
Write-Host "Path: $pleresnetpath"

Write-Host "`n`nRemovendo artefatos antigos da pasta de download"

ForEach ($item in $itenstoremovelist) {
    if (Test-Path $item) {
        Remove-Item $item -Recurse -Force
    }
}

Write-Host "`n`nParando os servicos do Pleres"
Get-Service | ? {$_.Name -imatch ( $servicesmatchlist -join '|' )} | ? {$_.Name -imatch "@option.Ambiente@" } | Stop-Service -Verbose
if ("@option.Ambiente@" -eq "dourado") {
    Get-Service | ? {$_.Name -eq 'Fila de Processamento'} | Stop-Service -Verbose
}

#create folder
New-Item -Path $downloadfolder -ItemType Directory -ErrorAction SilentlyContinue

#get information of every artifact
Write-Host "`n`nPegando informacoes dos artefatos"
$jobid = (Invoke-RestMethod -Method Get -Uri "$apiUrl/projects/$accountName/$project/build/$build" -Headers $headers).build.jobs.jobId
$artifacts = Invoke-RestMethod -Method Get -Uri "$apiUrl/buildjobs/$jobId/artifacts" -Headers $headers

#function for unzip files
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

$servicos = Get-Item -Path "d:\app\PleresNet.@option.Ambiente@\*" | % { $_.Name }
$artifactslist = $servicos | ? { $artifactslist -eq "${_}" }
if ("@option.Ambiente@"-eq "jambote") {

    if ("@option.ComunicacaoLabApoio@" -eq "false") {
        $artifactslist = @('SrvWin.IntegracaoQmatic')
    } else {
        $artifactslist = @('SrvWin.IntegracaoQmatic','SrvWin.ComunicacaoLaboratorioApoio') #list of all artifacts that you want to download
    }
}

ForEach ($artifact in $artifactslist) {
    Write-Host "`n`nBaixando o $artifact"
    $filename = ($artifacts | Where-Object {$_.name -eq "$artifact"}).Filename
    Invoke-RestMethod -Method Get -Uri "$apiUrl/buildjobs/$jobId/artifacts/$filename" -OutFile "$downloadfolder\$filename" -Headers @{ "Authorization" = "Bearer $token" } -Verbose
    Write-Host "`n`nDescompactando o $artifact"
    Unzip "$downloadfolder\$filename" "$downloadfolder\$artifact"

    #copy files IntegracaoQmatic
    if ($artifact -eq 'SrvWin.IntegracaoQmatic'){
        $folders = (Get-ChildItem -Path $pleresnetpath\$artifact\* -Directory)
        ForEach ($folder in $folders) {
            Write-Host "`n`n######################################################"
            Write-Host " "
            Write-Host "Copiando arquivos do $artifact para a pasta $folder"
            Write-Host " "
            Write-Host "######################################################"
            Copy-Item -Force -Recurse "$downloadfolder\$artifact\*" -Destination $folder -Exclude $excluded_files
            
        }
    }
    #copy files SrvWin.Comunicacao
    if (($artifact -eq 'SrvWin.Comunicacao') -and ("@option.Ambiente@" -ne "jade")){
        $folders = (Get-ChildItem -Path $pleresnetpath\$artifact\* -Directory)
        ForEach ($folder in $folders) {
            Write-Host "`n`n######################################################"
            Write-Host " "
            Write-Host "Copiando arquivos do $artifact para a pasta $folder"
            Write-Host " "
            Write-Host "######################################################"
            Copy-Item -Force -Recurse "$downloadfolder\$artifact\*" -Destination $folder -Exclude $excluded_files
        }
    }
    if (($artifact -eq 'SrvWin.Comunicacao') -and ("@option.Ambiente@" -eq "jade")){
        $folders = (Get-ChildItem -Path $pleresnetpath\$artifact\* -Directory | ? {$_.Name -imatch 'axial'})
        ForEach ($folder in $folders) {
            Write-Host "`n`n######################################################"
            Write-Host " "
            Write-Host "Copiando arquivos do $artifact para a pasta $folder"
            Write-Host " "
            Write-Host "######################################################"
            Copy-Item -Force -Recurse "$downloadfolder\$artifact\*" -Destination $folder -Exclude $excluded_files
        }
        $folders = (Get-ChildItem -Path $pleresnetpath\$artifact\* -Directory | ? {$_.Name -inotmatch 'axial'}).Name
        ForEach ($folder in $folders) {
            Write-Host "`n`n######################################################"
            Write-Host " "
            Write-Host "Copiando arquivos do $artifact para a pasta $folder"
            Write-Host " "
            Write-Host "######################################################"
            $subfolder = (Get-ChildItem -Path $pleresnetpath\$artifact\$folder\* -Directory)
            Copy-Item -Force -Recurse "$downloadfolder\$artifact\*" -Destination $subfolder -Exclude $excluded_files
        }
    }

    #copy files SrvWin.ComunicacaoLaboratorioApoio
    if (($artifact -eq 'SrvWin.ComunicacaoLaboratorioApoio') -and ("@option.Ambiente@" -inotmatch 'vermelho|lima|jade|jambo')){
        $folders = (Get-ChildItem -Path $pleresnetpath\$artifact\* -Directory)
        ForEach ($folder in $folders) {
            Write-Host "`n`n######################################################"
            Write-Host " "
            Write-Host "Copiando arquivos do $artifact para a pasta $folder"
            Write-Host " "
            Write-Host "######################################################"
            Copy-Item -Force -Recurse "$downloadfolder\$artifact\*" -Destination $folder -Exclude $excluded_files
        }
        if (Test-Path $pleresnetpath\$artifact'_Teleradiologia') {
            $folders = (Get-ChildItem -Path $pleresnetpath\$artifact'_Teleradiologia'\* -Directory)
            ForEach ($folder in $folders) {
                Write-Host "`n`n######################################################"
                Write-Host " "
                Write-Host "Copiando arquivos do $artifact para a pasta $folder"
                Write-Host " "
                Write-Host "######################################################"
                Copy-Item -Force -Recurse "$downloadfolder\$artifact\*" -Destination $folder -Exclude $excluded_files
            }
        }
    }
    if (($artifact -eq 'SrvWin.ComunicacaoLaboratorioApoio') -and ("@option.Ambiente@" -imatch 'vermelho|lima|jade|jambo')){
        $folders = (Get-ChildItem -Path $pleresnetpath\$artifact*\ -Directory | ? {$_.Name -inotmatch '_Teleradiologia'})
        ForEach ($folder in $folders) {
            Write-Host "`n`n######################################################"
            Write-Host " "
            Write-Host "Copiando arquivos do $artifact para a pasta $folder"
            Write-Host " "
            Write-Host "######################################################"
            Copy-Item -Force -Recurse "$downloadfolder\$artifact\*" -Destination $folder -Exclude $excluded_files
        }
        if (Test-Path $pleresnetpath\$artifact'_Teleradiologia') {
            $folders = (Get-ChildItem -Path $pleresnetpath\$artifact'_Teleradiologia'\* -Directory)
            ForEach ($folder in $folders) {
                Write-Host "`n`n######################################################"
                Write-Host " "
                Write-Host "Copiando arquivos do $artifact para a pasta $folder"
                Write-Host " "
                Write-Host "######################################################"
                Copy-Item -Force -Recurse "$downloadfolder\$artifact\*" -Destination $folder -Exclude $excluded_files
            }
        }
    }
}

Write-Host "`n`nIniciando os servicos do Pleres"
Get-Service | ? {$_.Name -imatch ( $servicesmatchlist -join '|' )} | ? {$_.Name -imatch "@option.Ambiente@" } | Start-Service -Verbose
if ("@option.Ambiente@" -eq "dourado") {
    Get-Service | ? {$_.Name -eq 'Fila de Processamento'} | Start-Service -Verbose
}

Write-Host "`n`nFinish!"