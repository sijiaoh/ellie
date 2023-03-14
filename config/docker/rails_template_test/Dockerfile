ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION}

RUN apt update -qq

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
  && apt update -qq \
  && apt install -y -qq google-chrome-stable

RUN apt clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app/

ARG NODE_VERSION
ENV NODE_VERSION ${NODE_VERSION}
ENV PATH /root/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
  && . ~/.nvm/nvm.sh \
  && nvm version \
  && nvm install ${NODE_VERSION}
RUN npm install --global yarn

COPY package.json yarn.lock /app/
RUN yarn install --frozen-lockfile

COPY Gemfile* /app/
RUN bundle config set --local without development \
  && bundle install --jobs=4 \
  && bundle clean --force

COPY . /app/
RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD ["./bin/test"]
