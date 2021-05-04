FROM node:10.17.0-buster-slim

LABEL maintainer="Ye Shu <ye.shu@hackinit.org>"

WORKDIR /code

# Install node_modules
COPY package.json /code/
COPY package-lock.json /code/

RUN npm install

COPY . /code/
RUN ./node_modules/.bin/gulp build

EXPOSE 3000

CMD ["node", "app.js"]
