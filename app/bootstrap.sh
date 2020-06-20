#/bin/bash
# Check if first run
# If first run, make migrations, migrate, create superuser
cd /opt/self-service
#Setup Steps
if [ ! -f /config/.keep_secret ]; then
    SETTINGS_STRING="--settings-file /config/settings.py"
    if [ ! -z "$DEBUG" ]; then SETTINGS_STRING="$SETTINGS_STRING --debug $DEBUG"; fi
    if [ ! -z "$ALLOWED_HOSTS" ]; then SETTINGS_STRING="$SETTINGS_STRING --allowed-hosts $ALLOWED_HOSTS"; fi
    if [ ! -z "$SMTP_HOST" ]; then SETTINGS_STRING="$SETTINGS_STRING --smtp-host $SMTP_HOST"; fi
    if [ ! -z "$SMTP_PORT" ]; then SETTINGS_STRING="$SETTINGS_STRING --smtp-port $SMTP_PORT"; fi
    if [ ! -z "$SMTP_HOST_USER" ]; then SETTINGS_STRING="$SETTINGS_STRING --smtp-host-user $SMTP_HOST_USER"; fi
    if [ ! -z "$SMTP_HOST_PASSWORD" ]; then SETTINGS_STRING="$SETTINGS_STRING --smtp-host-password $SMTP_HOST_PASSWORD"; fi
    if [ ! -z "$SMTP_USE_TLS" ]; then SETTINGS_STRING="$SETTINGS_STRING --smtp-use-tls $SMTP_USE_TLS"; fi
    if [ ! -z "$SMTP_SENDER_EMAIL" ]; then SETTINGS_STRING="$SETTINGS_STRING --smtp-sender-email=$SMTP_SENDER_EMAIL"; fi
    echo $SETTINGS_STRING
    pipenv run python tools/setup_settings.py $SETTINGS_STRING 2> /config/errlog > /config/log
    touch /config/.keep_secret
fi

# Copy config files to correct folders
cp /config/settings.py /opt/self-service/dynatrace_admin/settings.py
cp /config/user_variables.py /opt/self-service/framework/user_variables.py
cp -r /opt/self-service/static/* /static/
cp -r /config/saml/* /opt/self-service/saml/


pipenv run python manage.py makemigrations
pipenv run python manage.py migrate
pipenv run python manage.py synczones
pipenv run python manage.py safesuperuser --username=$DJANGO_SUPERUSER_USERNAME --password=$DJANGO_SUPERUSER_PASSWORD --email=$DJANGO_SUPERUSER_EMAIL

crond &&
pipenv run gunicorn --env DJANGO_SETTINGS_MODULE=dynatrace_admin.settings dynatrace_admin.wsgi --bind 0.0.0.0:8000 --access-logfile -
