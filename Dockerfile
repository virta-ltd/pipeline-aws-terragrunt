FROM ubuntu:latest
WORKDIR /prepare
RUN apt update
RUN apt install -y gnupg software-properties-common curl unzip
RUN apt install -y git
# AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN rm awscliv2.zip
RUN ./aws/install
# Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install terraform
# Terragrunt
RUN apt install -y jq
RUN curl -L "https://github.com/gruntwork-io/terragrunt/releases/download/$(curl https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest -s | jq -r .tag_name)/terragrunt_linux_amd64" -o "/usr/local/bin/terragrunt"
RUN chmod u+x /usr/local/bin/terragrunt
WORKDIR /app
