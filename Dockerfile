FROM node:8.12-alpine

ARG MAILTRAIN_VERSION=1.24.1

RUN set -ex && apk add --no-cache curl git python \
  && cd /tmp \
  && curl -fSL https://github.com/andris9/mailtrain/archive/v${MAILTRAIN_VERSION}.tar.gz -o mailtrain.tar.gz \
  && tar xzf mailtrain.tar.gz \
  && mkdir /app \
  && mv mailtrain-${MAILTRAIN_VERSION}/*  /app

WORKDIR /app/

RUN npm install --no-progress --production

ENV NODE_ENV production

EXPOSE 3000

ENTRYPOINT ["sh", "/app/docker-entrypoint.sh"]

CMD ["node", "index.js"]
