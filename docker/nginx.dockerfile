
FROM nginx:1.29.1-alpine

RUN rm -f /etc/nginx/conf.d/default.conf

RUN mkdir -p /usr/share/nginx/html/static-content

WORKDIR /etc/nginx

CMD ["nginx", "-g", "daemon off;"]
