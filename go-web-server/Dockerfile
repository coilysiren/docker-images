FROM circleci/golang:1.13

# explicitly set the user to root
USER root

# set shell to bash
SHELL ["/bin/bash", "-c"]

# ignore prompts
ENV DEBIAN_FRONTEND=noninteractive

# install apt deps
RUN sudo apt install -y \
  python3-pip \
  unzip

# install pip deps
RUN pip3 install awscli

# install terraform
# hashicorp please ... provide an apt package ... please I beg of you!!!
# relevant issue => https://github.com/hashicorp/terraform/issues/17794
ENV TERRAFORM_VERSION="0.12.23"
RUN \
  wget https://releases.hashicorp.com/terraform/"$TERRAFORM_VERSION"/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip --quiet && \
  unzip terraform_"$TERRAFORM_VERSION"_linux_amd64.zip && \
  sudo mv terraform /usr/local/bin/ && \
  terraform --version

# install pulumi
RUN curl -fsSL https://get.pulumi.com | sh
RUN pulumi --version
