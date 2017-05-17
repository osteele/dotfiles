d.exec () {
  docker run \
    -v yarn_cache:/root/.cache/yarn \
    -v `pwd`:/app \
    -v $(basename $PWD)_node_modules:/app/node_modules \
    -p 3000:3000 \
    -it \
    node \
    "$@"
}

d.bash () {
  d.exec bash -c 'cd /app && bash --login'
}

d.yarn () {
  d.exec bash -c "cd /app && yarn $@"
}

d.run () {
  d.yarn start
}
