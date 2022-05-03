FROM ubuntu:latest

# This is the release of Vault-SSH-Helper to pull in.
ARG VSH_VERSION=0.2.1

# updates
RUN apt update -y

#add curl and unzip
RUN apt install -y curl unzip wget

# setup SSH
RUN apt install openssh-server sudo -y
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 vault 
RUN echo 'vault:rootrootroot' | chpasswd
RUN service ssh start
EXPOSE 22

# setup vault helper
RUN wget https://releases.hashicorp.com/vault-ssh-helper/${VSH_VERSION}/vault-ssh-helper_${VSH_VERSION}_linux_amd64.zip && \
    unzip vault-ssh-helper_${VSH_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    chmod 0755 /usr/local/bin/vault-ssh-helper && \
    chown root:root /usr/local/bin/vault-ssh-helper

COPY run.sh ./
RUN ["chmod", "+x", "./run.sh"]
CMD ./run.sh








