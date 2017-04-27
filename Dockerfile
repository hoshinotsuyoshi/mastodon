FROM ruby:2.4.1-alpine

ENV RAILS_ENV=production \
    NODE_ENV=production

EXPOSE 3000 4000

WORKDIR /mastodon

COPY . .

RUN BUILD_DEPS=" \
    postgresql-dev \
    libxml2-dev \
    libxslt-dev \
    build-base" \
 && apk -U upgrade && apk add \
    $BUILD_DEPS \
    nodejs \
    libpq \
    libxml2 \
    libxslt \
    ffmpeg \
    file \
    imagemagick \
 && npm install -g npm@3 && npm install -g yarn \
 && bundle install -j9 --deployment --without test development \
 && yarn \
 && yarn cache clean \
 && npm -g cache clean \
 && apk del $BUILD_DEPS \
 && rm -rf /tmp/* /var/cache/apk/* \
 && ruby precompile.rb
