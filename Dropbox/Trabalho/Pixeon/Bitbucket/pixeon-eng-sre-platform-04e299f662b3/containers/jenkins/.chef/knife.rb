current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "jenkins"
client_key               "#{current_dir}/jenkins.pem"
chef_server_url          "https://chef.pixeon.cloud/organizations/pixeon"
#cookbook_path            ["#{current_dir}/../cookbooks"]
