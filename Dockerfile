FROM ubuntu:17.10

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV HOME /root
ENV NPM_CONFIG_LOGLEVEL warn

RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils \
  ca-certificates \
  && apt-get purge --auto-remove \
  && rm -rf /tmp/* /var/lib/apt/lists/*

COPY sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
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
  && apt-get purge --auto-remove \
  && rm -rf /tmp/* /var/lib/apt/lists/*


RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
  && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
  && chsh -s /bin/zsh

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
    && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && apt-get purge --auto-remove \
    && rm -rf /tmp/* /var/lib/apt/lists/*

COPY .vimrc /root/.vimrc

RUN curl -fsLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  && rm -rf /tem/*

WORKDIR /root

RUN npm install -g cnpm # --registry=https://registry.npm.taobao.org

RUN cnpm install -g eslint \
 eslint-config-airbnb \
 eslint-plugin-jsx-a11y \
 eslint-plugin-react \
 eslint-plugin-import \
 babel-eslint \
 eslint-import-resolver-webpack

CMD ["zsh"]
