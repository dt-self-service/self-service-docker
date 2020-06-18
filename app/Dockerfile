FROM python:alpine

ENV PUID=2772

COPY operations/sync_management_zones.sh /operations/sync_management_zones.sh
RUN pip install pipenv &&\
    apk --no-cache add git postgresql-dev gcc python3-dev musl-dev g++ libxslt-dev xmlsec-dev &&\
    adduser django-server --uid $PUID --disabled-password &&\
    mkdir -p /opt/self-service &&\
    mkdir /static &&\
    chown -R $PUID:$PUID /opt/self-service &&\
    chown -R $PUID:$PUID /static &&\
    chmod 755 /operations/sync_management_zones.sh &&\
    (crontab -l 2>/dev/null; echo "0 * * * * /operations/sync_management_zones.sh") | crontab -

USER django-server

RUN git clone https://github.com/dt-self-service/self-service-app /opt/self-service &&\
    cd /opt/self-service/framework &&\
    git submodule init &&\
    #To Pull the submodules we need to change from SSH method to HTTPS
    sed -i 's/git\@github\.com\:/https\:\/\/github.com\//g' ../.git/config &&\
    git submodule update &&\
#    git checkout --track origin/dev  &&\
    cd ../ &&\
    pipenv install

COPY --chown=django-server:django-server bootstrap.sh /bootstrap.sh

EXPOSE 8000
VOLUME ["/static", "/config"]
CMD ["sh","/bootstrap.sh"]
