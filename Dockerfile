FROM node:14.21-alpine as builder
WORKDIR /webapp
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm build

FROM nginx:1.23.3
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /webapp/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]