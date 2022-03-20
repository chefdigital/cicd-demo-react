# module install
FROM node:16.14.2-alpine3.15 as module-install-stage
# set working directory
WORKDIR /app
# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/package.json

RUN apk add yarn
RUN yarn install --production

# build
FROM node:16.14.2-alpine3.15 as build-stage
COPY --from=module-install-stage /app/node_modules/ /app/node_modules
WORKDIR /app
COPY . .
RUN yarn build

# serve
FROM node:16.14.2-alpine3.15
COPY --from=build-stage /app/build/ /app/build
RUN npm install -g serve
# start app
CMD serve -s /app/build -l 3000

# build from CMD
# docker build -t chefdigitaldemo/cicd-demo-react:latest .

# test
# docker run -p 3000:3000 chefdigitaldemo/cicd-demo-react