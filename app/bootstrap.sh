#/bin/sh

# Copy config files to correct folders
cp /config/settings.py /opt/self-service/dynatrace_admin/settings.py
cp /config/user_variables.py /opt/self-service/framework/user_variables.py
cp -r /opt/self-service/static/* /static/
cp -r /config/saml/* /opt/self-service/saml/

# Check if first run
# If first run, make migrations, migrate, create superuser
cd /opt/self-service
pipenv run python manage.py check
pipenv run python manage.py makemigrations
pipenv run python manage.py migrate
#pipenv run python manage.py collectstatic
pipenv run python manage.py safesuperuser --username=$DJANGO_SUPERUSER_USERNAME --password=$DJANGO_SUPERUSER_PASSWORD --email=$DJANGO_SUPERUSER_EMAIL
pipenv run gunicorn --env DJANGO_SETTINGS_MODULE=dynatrace_admin.settings dynatrace_admin.wsgi --bind 0.0.0.0:8000
