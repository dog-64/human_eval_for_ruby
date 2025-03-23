BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

NAME   := dockerhub.duletsky.ru/novik_app
TAG    := $$(git log -1 --pretty=%!H(MISSING))
IMG    := ${NAME}:${TAG}
LATEST := ${NAME}:latest

ARGS = $(filter-out $@,$(MAKECMDGOALS))
%:
	@:
.PHONY: spec test

test:
	bundle exec rspec --require spec_helper --format documentation --color

rubocop:
	bundle exec rubocop -A -F ./lib ./spec Gemfile

standard:
	bundle exec standardrb --format progress

critic:
	rubycritic -no-browser --mode-ci

audit:
	bundle exec bundle-audit --update
