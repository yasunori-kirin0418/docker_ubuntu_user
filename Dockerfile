FROM ubuntu:latest

MAINTAINER yasunori0418
LABEL description="Ubuntuに日本語ユーザーを作成します。"

ENV LANG=ja_JP.UTF-8

RUN apt-get update && \
    apt-get install -y \
        sudo git curl vim exa bat zsh xdg-user-dirs \
        language-pack-ja-base language-pack-ja locales && \
    locale-gen ja_JP.UTF-8

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
