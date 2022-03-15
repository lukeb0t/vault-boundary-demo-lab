FROM ubuntu:20.04

# This is the release of Vault-SSH-Helper to pull in.
ARG VSH_VERSION=0.2.1

# fetch tools
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install curl iputils-ping wget unzip -y && \
    wget -O /tmp/dumb-init.deb https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_amd64.deb && \
    dpkg -i /tmp/dumb-init.deb

# fetch vault helper
RUN wget https://releases.hashicorp.com/vault-ssh-helper/${VSH_VERSION}/vault-ssh-helper_${VSH_VERSION}_linux_amd64.zip && \
    unzip vault-ssh-helper_${VSH_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    chmod 0755 /usr/local/bin/vault-ssh-helper && \
    chown root:root /usr/local/bin/vault-ssh-helper

# setup SSH
RUN apt-get install openssh-server -y
RUN service ssh start

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN useradd -ms /bin/bash vaultuser
RUN usermod -aG sudo vaultuser

EXPOSE 22

COPY run.sh ./
RUN ["chmod", "+x", "./run.sh"]
CMD ./run.sh



