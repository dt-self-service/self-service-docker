#!/bin/sh
cd /opt/self-service/
su django-server -c 'pipenv run python manage.py synczones'