FROM ruby:2.6

# Node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -qq -y --no-install-recommends \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  apt-transport-https \
  imagemagick \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /typeracer-api
WORKDIR /typeracer-api
ADD . /typeracer-api

# Add bundle entry point to handle bundle cache
# If we want to cache not on the image but using
# a volume we need to remove bundle/yarn install
# from here and activate the volume on docker-compose
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/bin/docker-entrypoint"]

# Bundle installs with binstubs to our custom /bundle_box/bin volume path.
# Let system use those stubs.
# If we want to cache not on the image but using a volume we need to remove
# bundle/yarn install from here and activate the volume on docker-compose
ENV BUNDLE_PATH=/bundle \
  BUNDLE_BIN=/bundle/bin \
  BUNDLE_JOBS=2 \
  GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
