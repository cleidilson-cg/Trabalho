FROM jenkins/jenkins:lts
USER root 
# Install Docker
RUN apt-get update && \
    apt-get -y install apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get -y install docker-ce
# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && \ 
    chmod +x /usr/local/bin/docker-compose
# Install docker-machine
RUN base=https://github.com/docker/machine/releases/download/v0.14.0 &&   curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && install /tmp/docker-machine /usr/local/bin/docker-machine
RUN usermod -a -G docker jenkins
RUN adduser jenkins sudo 
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# Install Rancher-compose and rancher-cli
ADD rancher-compose /usr/local/bin/
ADD rancher /usr/local/bin/
USER jenkins
