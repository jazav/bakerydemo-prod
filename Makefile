PROD_COMPOSE_FILE ?= docker-compose
# Project variables
PROJECT_NAME ?= bakerydemo
ORG_NAME ?= lemma
REPO_NAME ?= bakerydemo
# Use these settings to specify a custom Docker registry
DOCKER_REGISTRY ?= docker.io

APP_SERVICE_NAME ?= django
APP_NAME ?= $(PROJECT_NAME)_$(APP_SERVICE_NAME)

VERSION ?= 0.1.0

up_prod:
	@ docker-compose -f $(PROD_COMPOSE_FILE).yml up --build
down_prod:
	@ docker-compose -f $(PROD_COMPOSE_FILE).yml down -v
rm_all:
	@ docker system prune --all --force
	@ docker volume prune --force
rm_vol:
	@ docker volume prune --force
load:
	@# docker-compose -f $(COMPOSE_FILE).yml run app /venv/bin/python manage.py load_initial_data
	@ docker exec $(APP_NAME)_1 /venv/bin/python ./manage.py load_initial_data
del_renditions:
	@# docker-compose -f $(COMPOSE_FILE).yml run app /venv/bin/python manage.py delete_renditions
	@ docker exec $(APP_NAME)_1 /venv/bin/python ./manage.py delete_renditions
pip_freeze:
	@# docker-compose -f $(COMPOSE_FILE).yml run app /venv/bin/python manage.py pip_freeze
	@ docker exec $(APP_NAME)_1 /venv/bin/python ./manage.py pip_freeze
django_shell:
	@ docker-compose -f $(PROD_COMPOSE_FILE).yml run django /venv/bin/python manage.py django_shell
shell:
	@docker exec -t -i $(APP_NAME)_1 /bin/bash
nginx_shell:
	@docker exec -t -i $(PROJECT_NAME)_nginx_1 /bin/bash
collect:
	@ docker exec $(APP_NAME)_1 /venv/bin/python ./manage.py collectstatic --noinput
update_index:
	@ docker-compose -f $(PROD_COMPOSE_FILE).yml run app /venv/bin/python manage.py update_index
vol_list:
	@ docker volume ls -q
