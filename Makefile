generate_toc:
	markdown-toc -i README.md

compile:
	sudo rm -rf compiled_starters/*
	bundle exec ruby template_compiler/compile.rb

test: compile download_starter_testers
	bundle exec ruby tests/test_all.rb

test_redis: compile download_starter_testers
	bundle exec ruby tests/test_all.rb redis

test_docker: compile download_starter_testers
	bundle exec ruby tests/test_all.rb docker

test_docker_go: compile download_starter_testers
	bundle exec ruby tests/test_all.rb docker go

test_docker_nim: compile download_starter_testers
	bundle exec ruby tests/test_all.rb docker nim

test_docker_c: compile download_starter_testers
	bundle exec ruby tests/test_all.rb docker c

test_redis_python: compile download_starter_testers
	bundle exec ruby tests/test_all.rb redis python

test_redis_ruby: compile download_starter_testers
	bundle exec ruby tests/test_all.rb redis ruby

test_redis_go: compile download_starter_testers
	bundle exec ruby tests/test_all.rb redis go

test_redis_c: compile download_starter_testers
	bundle exec ruby tests/test_all.rb redis c

sync_with_github: compile
	bundle exec ruby repo_syncer/sync.rb

download_starter_testers:
	mkdir -p .starter_testers
	test -f .starter_testers/redis || make download_redis_starter_tester
	test -f .starter_testers/docker || make download_docker_starter_tester

download_redis_starter_tester:
	curl --fail -Lo .starter_testers/redis https://github.com/codecrafters-io/redis-starter-tester/releases/download/v54/v54_linux_amd64
	chmod +x ./.starter_testers/redis

download_docker_starter_tester:
	curl --fail -Lo .starter_testers/docker https://github.com/codecrafters-io/docker-starter-tester/releases/download/v24/v24_linux_amd64
	chmod +x ./.starter_testers/docker
