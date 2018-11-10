docker ps -aq --no-trunc -f status=exited | xargs docker rm
docker images -q --filter dangling=true | xargs docker rmi
# docker rm $(docker ps -q -f 'status=exited')
# docker rmi $(docker images -q -f "dangling=true")