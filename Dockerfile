FROM alexzolotarev/basedjango:0.1.0

# define argument to customize the application name
ARG PROJECT_ARG
# copy the project code and config
COPY $PROJECT_ARG /code/$PROJECT_ARG

COPY docker/all-in-one/scripts/docker-entrypoint.sh /code/

RUN rm -r *.egg-info

# we need it here or in docker-compose to docker-gen
#EXPOSE 3031

# Add custom environment variables needed by Django or your settings file here:
ENV DJANGO_SETTINGS_MODULE=$PROJECT_ARG.settings.production DJANGO_DEBUG=off

# Call collectstatic with dummy environment variables:
RUN DATABASE_URL=postgres://none REDIS_URL=none /venv/bin/python manage.py collectstatic --noinput
# make sure static files are writable by uWSGI process
RUN mkdir -p /code/$PROJECT_ARG/media/images && mkdir -p /code/$PROJECT_ARG/media/original_images && chown -R 1000:2000 /code/$PROJECT_ARG/media

# mark the destination for images as a volume
#VOLUME ["/code/$PROJECT_ARG/media/images/"]

## start uWSGI, using a wrapper script to allow us to easily add more commands to container startup:
#ENTRYPOINT ["/code/docker-entrypoint.sh"]
#
#LABEL application=$PROJECT_ARG
## Start uWSGI
#CMD ["/venv/bin/uwsgi", "--strict", "--show-config", "./uwsgi.ini"]
