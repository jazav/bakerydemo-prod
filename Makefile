SHELL := /bin/bash

action:
args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

label_add_db:
	@ docker node update --label-add purpose=database $(call args)
	@# docker node update --label-add purpose=database docker-desktop
label_add_web:
	@ docker node update --label-add purpose=web $(call args)
label_rm:
	@ docker node update --label-rm purpose $(call args)
label_show:
	@ docker node ls -q | xargs docker node inspect -f '{{ .ID }} [{{ .Description.Hostname }}]: {{ .Spec.Labels }}'
#	@ docker node ls -q | xargs docker node inspect \
# 	-f '{{ .ID }} [{{ .Description.Hostname }}]: {{ range $k, $v := .Spec.Labels }}{{ $k }}={{ $v }} {{end}}'
stack_deploy:
	@ docker stack deploy --compose-file docker-compose.yml -c docker-compose-viz.yml bakerydemo

stack_ext_deploy:
	@ docker stack deploy --compose-file docker-compose.yml -c docker-compose-viz.yml -c docker-compose-ext.yml bakerydemo

stack_rm:
	@ docker stack rm bakerydemo

stack_errors:
	@ docker stack ps --no-trunc bakerydemo

scale_django_0:
	@ docker service scale bakerydemo_django=0

scale_django_1:
	@ docker service scale bakerydemo_django=1

load:
	@ docker-compose -f docker-compose.yml run django /venv/bin/python manage.py load_initial_data
#	@ docker exec $(APP_NAME)_1 /venv/bin/python ./manage.py load_initial_data

set_load_on:
	@ export DJANGO_LOAD_INITIAL_DATA = on

set_load_off:
	@ export DJANGO_LOAD_INITIAL_DATA = off

scale_nginx_0:
	@ docker service scale bakerydemo_nginx=0

scale_nginx_1:
	@ docker service scale bakerydemo_nginx=1

scale_postgresql_0:
	@ docker service scale bakerydemo_postgresql=0

scale_postgresql_1:
	@ docker service scale bakerydemo_postgresql=1

visualizer_run:
#https://github.com/dockersamples/docker-swarm-visualizer
	@ docker service create --name=viz --publish=8080:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock alexellis2/visualizer-arm:latest

swarm_init:
	@docker swarm init

swarm_leave:
	@ docker swarm leave --force

docker_start:
	@ sudo systemctl start docker
	@ sudo chmod 666 /var/run/docker.sock

git_clone:
	@ git clone https://github.com/jazav/bakerydemo_prod.git
	@ sudo chmod -R 777 bakerydemo_prod

git_update:
	@ git pull origin master

shell:
	@ docker exec -it 288e3d764b74 bash

