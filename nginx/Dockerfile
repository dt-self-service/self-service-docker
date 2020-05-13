FROM nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf &&\
	apk add --no-cache openssl &&\
	adduser -u 2772 -D -S -G www-data self-service

COPY nginx.conf /etc/nginx/conf.d
COPY bootstrap.sh /bootstrap.sh
#USER self-service
CMD ["sh", "bootstrap.sh"]
