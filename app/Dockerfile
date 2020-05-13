FROM python:alpine

ENV PUID=2772
ENV PGID=2772
RUN pip install pipenv &&\
    apk --no-cache add git openssh-client postgresql-dev gcc python3-dev musl-dev g++ libxslt-dev xmlsec-dev &&\
    adduser django-server --uid $PUID --disabled-password &&\
    mkdir -p /opt/self-service &&\
    mkdir /static &&\
    chown -R $PUID:$PUID /opt/self-service &&\
    chown -R $PUID:$PUID /static &&\
    ssh-keyscan -H github.com >> /etc/ssh/ssh_known_hosts
USER django-server
COPY --chown=django-server:django-server id_rsa /home/django-server/git_ssh
RUN eval $(ssh-agent) &&\
    ssh-add /home/django-server/git_ssh && \
    git clone --recursive git@github.com:dt-self-service/self-service-app /opt/self-service &&\
    cd /opt/self-service &&\
    cat Pipfile &&\
    pipenv install

COPY --chown=django-server:django-server bootstrap.sh /bootstrap.sh

EXPOSE 8000
VOLUME ["/static", "/config"]
CMD ["sh","/bootstrap.sh"]
