FROM ubuntu:22.10

MAINTAINER yasunori0418
LABEL description="Ubuntu 22.10環境に日本語ユーザーを作成します。"

RUN apt-get update && \
    apt-get install -y \
        sudo \
        git \
        curl \
        vim \
        exa \
        bat \
        zsh

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG PASSWORD=user

RUN groupadd -g $GID $GROUPNAME && \
    useradd --create-home --shell=/bin/bash --uid=$UID --gid=$GID --groups sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME

RUN xdg-user-dirs-update
