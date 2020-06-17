FROM nginx:stable-alpine

COPY . index.html /usr/share/nginx/html/

RUN apk add tidy

EXPOSE 80