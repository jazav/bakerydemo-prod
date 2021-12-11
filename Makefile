args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

label_add_db:
	@ docker node update --label-add purpose=database $(call args)
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

stack_rm:
	@ docker stack rm bakerydemo

stack_errors:
	@ docker stack ps --no-trunc bakerydemo

visualizer_run:
#https://github.com/dockersamples/docker-swarm-visualizer
	@ docker service create --name=viz --publish=8080:8080/tcp --constraint=node.role==manager
	--mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock alexellis2/visualizer-arm:latest

swarm_init:
	@docker swarm init
swarm_leave:
	@ docker swarm leave --force

docker_start:
	@ sudo systemctl start docker
	@ sudo chmod 666 /var/run/docker.sock

git_clone:
	@ git clone https://github.com/jazav/bakerydemo_prod.git

git_update:
	@ git pull origin master
	@ sudo chmod -R 777 bakerydemo_prod