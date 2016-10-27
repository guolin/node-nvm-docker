FROM ubuntu:16.04

# 配置环境变量
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 4.2.1
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PHANTOM_JS phantomjs-1.9.8-linux-x86_64

# 安装基础依赖
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get -y update && apt-get -y install build-essential libssl-dev curl
RUN apt-get -y install libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev g++
# PhantomJS
RUN apt-get -y install chrpath libxft-dev
RUN apt-get -y install libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev
RUN apt-get -y install git wget

# 安装Node nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash \
	&& source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION \
	&& nvm use $NODE_VERSION

# 安装Node Global
RUN source ~/.bashrc
RUN npm install -g babel@5.x bunyan gulp knex

# 安装PhantomJS
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 \
	&& tar xvjf $PHANTOM_JS.tar.bz2 \
	&& mv $PHANTOM_JS /usr/local/share \
	&& ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

CMD node -v
