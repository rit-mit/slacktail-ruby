FROM ruby:2.6.5

ENV DEBCONF_NOWARNINGS=yes
RUN apt-get update -qq && apt-get install -y ca-certificates openssl locales imagemagick libmagickcore-dev libmagickwand-dev
RUN locale-gen ja_JP.UTF-8

ARG APP_ROOT_IN_CONTAINER=/usr/src/app
ARG CHANNELS_CONFIG_DIR_IN_CONTAINER=/channels_config
ARG TMP_DIR_IN_CONTAINER=/tmp

ENV BUNDLE_JOBS=4 \
TZ=Asia/Tokyo \
APP_ROOT=${APP_ROOT_IN_CONTAINER} \
CACHE_DIR="${TMP_DIR_IN_CONTAINER}/cache" \
PID_DIR="${TMP_DIR_IN_CONTAINER}/pid" \
LOG_DIR="${TMP_DIR_IN_CONTAINER}/log" \
CHANNELS_CONFIG_PATH="${CHANNELS_CONFIG_DIR_IN_CONTAINER}/channels_config.yml" \
SLACK_API_TOKEN_FILE_PATH="${CHANNELS_CONFIG_DIR_IN_CONTAINER}/slack_tokens.yml" \
LANG="ja_JP.UTF-8" \
LANGUAGE="ja_JP:ja" \
LC_ALL="ja_JP.UTF-8"

WORKDIR ${APP_ROOT_IN_CONTAINER}
VOLUME /data

RUN mkdir -p ${APP_ROOT_IN_CONTAINER}
RUN mkdir -p ${CHANNELS_CONFIG_DIR_IN_CONTAINER}
RUN mkdir -p ${TMP_DIR_IN_CONTAINER}
RUN mkdir -p ${PID_DIR}
RUN mkdir -p ${LOG_DIR}
RUN mkdir -p ${CACHE_DIR}

COPY Gemfile ${APP_ROOT_IN_CONTAINER}
COPY Gemfile.lock ${APP_ROOT_IN_CONTAINER}
RUN gem install bundler -v 1.17.2 && bundle config git.allow_insecure true && bundle install

COPY ./ ${APP_ROOT_IN_CONTAINER}
COPY ./channels_config ${CHANNELS_CONFIG_DIR_IN_CONTAINER}

ENTRYPOINT ["bin/slacktail", "start"]

