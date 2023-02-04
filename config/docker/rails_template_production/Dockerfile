FROM ruby:3.1.2

RUN apt update -qq \
  && rm -rf /var/lib/apt/lists/*

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
RUN bundle config set --local without development test \
  && bundle install --jobs=4 \
  && bundle clean --force

COPY . /app/

ARG RAILS_MASTER_KEY
ARG RAILS_TEMPLATE_DATABASE_PASSWORD

ENV RAILS_ENV production
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}
ENV RAILS_TEMPLATE_DATABASE_PASSWORD ${RAILS_TEMPLATE_DATABASE_PASSWORD}

RUN ./bin/rails assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server"]
