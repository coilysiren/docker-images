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
  unzip \
  software-properties-common

# install pip deps
RUN pip3 install awscli

# install terraform
# hashicorp please ... provide an apt package ... please I beg of you!!!
# relevant issue => https://github.com/hashicorp/terraform/issues/17794
ENV TERRAFORM_VERSION="0.12.24"
RUN \
  wget https://releases.hashicorp.com/terraform/"$TERRAFORM_VERSION"/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip --quiet && \
  unzip terraform_"$TERRAFORM_VERSION"_linux_amd64.zip && \
  sudo mv terraform /usr/local/bin/ && \
  terraform --version

# install yq
# github repo => https://github.com/mikefarah/yq
RUN \
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64 && \
  sudo add-apt-repository ppa:rmescandon/yq && \
  sudo apt update && \
  sudo apt install yq -y && \
  yq --version
