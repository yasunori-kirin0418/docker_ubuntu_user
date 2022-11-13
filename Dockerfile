FROM ubuntu:latest
## M1 macユーザーには必要。
## 下のコメントアウトを解除して、上をコメントアウトする必要があるかも
#FROM --platform=linux/amd64 ubuntu:latest

MAINTAINER yasunori0418
LABEL description="Ubuntuに日本語ユーザーを作成します。"

ENV LANG=ja_JP.UTF-8

RUN apt-get update && \
    apt-get install -y \
        sudo git curl vim exa bat zsh xdg-user-dirs \
        language-pack-ja-base language-pack-ja locales && \
    locale-gen ja_JP.UTF-8

ARG USER_NAME=user
ARG GROUP_NAME=user
ARG UID=1000
ARG GID=1000
ARG PASSWORD=user

RUN groupadd -g $GID $GROUP_NAME && \
    useradd --create-home --shell=/bin/bash --uid=$UID --gid=$GID --groups sudo $USER_NAME && \
    echo $USER_NAME:$PASSWORD | chpasswd && \
    echo "$USER_NAME  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER_NAME
WORKDIR /home/$USER_NAME

RUN xdg-user-dirs-update
