## Network Load Balancer
A receita de NLB utiliza o conceito de módulos do Terraform e seu path está descrito no "*main.tf*" de cada ambiente.
### Deploy
Para efetuar o deploy é necessário seguir os passos abaixo:

- Utilizar o *profile* **pixeon-account** para a autenticação na Aws
	+ Na *home* de seu usuário pessoal, criar uma pasta chamada "***.aws***"
	+ Dentro da pasta "***.aws***", criar dois arquivos:
		- **config**, com o texto abaixo:  
			`[pixeon-account]`  
		- **credentials**, com o text abaixo:  
			`[pixeon-account]`  
			`aws_access_key_id = AAAAAAAAAAAAAAAAAAAA`  
			`aws_secret_access_key = SecretSecretSecretSecretSecretSecretSecr`

- Clonar o repositório **eng-sre-platform**

- Acessar a pasta do ambiente desejado
	+ **Ex.:** *eng-sre-platform/terraform/pixeon-cloud/iaas/aws/load-balancer/nlb/dev*

- Na pasta do ambiente escolhido, rodar os comandos abaixo:
	+ `terraform init` Inicializa a receita do Terraform
	+ `terraform plan` Exibe exatamente o que será aplicado no deploy, informando as alterações em comparação com o ultimo *state*
	+ `terraform apply` Aplica as configurações desejadas caso o *plan* tenha sido executado com sucesso