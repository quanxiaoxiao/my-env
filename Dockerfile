FROM ubuntu:17.10

ENV TZ=Asia/Shanghai
ENV HOME /root
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils \
  locales \
  ca-certificates \
  && apt-get purge --auto-remove \
  && rm -rf /tmp/* /var/lib/apt/lists/*

COPY sources.list /etc/apt/sources.list

RUN locale-gen zh_CN.UTF-8 && \
  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
RUN locale-gen zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh
ENV LC_ALL zh_CN.UTF-8

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  bash \
  curl \
  git \
  build-essential \
  ttf-freefont \
  sudo \
  wget \
  tmux \
  libav-tools \
  libgconf-2-4 \
  shellcheck \
  zsh \
  silversearcher-ag \
  vim \
  iputils-ping \
  traceroute \
  net-tools \
  iproute2 \
  && apt-get purge --auto-remove \
  && rm -rf /tmp/* /var/lib/apt/lists/*


RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
  && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
  && chsh -s /bin/zsh

COPY .vimrc /root/.vimrc

RUN curl -fsLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

WORKDIR /root

RUN git clone https://github.com/gpakosz/.tmux.git \
  && ln -s -f .tmux/.tmux.conf \
  && cp .tmux/.tmux.conf.local .

CMD ["zsh"]
