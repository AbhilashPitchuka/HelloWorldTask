FROM node:14.21-alpine
WORKDIR /webapp
COPY . .
RUN npm install
RUN npm start

FROM nginx:1.23.3
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /webapp/start .
ENTRYPOINT ["nginx", "-g", "daemon off;"]