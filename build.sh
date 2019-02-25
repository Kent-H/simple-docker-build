#!/bin/bash

# project-specific information
NAME="docker-image-name"
REPO=""

# gather working tree information
GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
GIT_COMMIT_NUM="$(git rev-list --count HEAD)"
GIT_COMMIT="$(git log --format='%H' -n 1)"
if [[ "$(git ls-files --others --modified --exclude-standard)" != "" ]]; then
	CHANGED="true"
fi

# build docker image
docker build -t "$NAME" \
	--build-arg "GIT_BRANCH=$GIT_BRANCH" \
	--build-arg "GIT_COMMIT_NUM=$GIT_COMMIT_NUM" \
	--build-arg "GIT_COMMIT=$GIT_COMMIT" \
	--build-arg "CHANGED=$CHANGED" .

# if working tree is clean, tag based on git version information
if [[ "$CHANGED" != "true" ]]; then
	if [[ "$GIT_BRANCH" == "master" ]]; then
	    # remove existing
		docker rmi "$REPO$NAME:0.$GIT_COMMIT_NUM" > /dev/null 2>&1  || true
		docker tag "$NAME" "$REPO$NAME:0.$GIT_COMMIT_NUM" && echo "Successfully tagged $REPO$NAME:0.$GIT_COMMIT_NUM"
	else
		docker rmi "$REPO$NAME:$(echo "$GIT_BRANCH" | sed -e 's/\//_/g')-0.$GIT_COMMIT_NUM" > /dev/null 2>&1 || true
		docker tag "$NAME" "$REPO$NAME:$(echo "$GIT_BRANCH" | sed -e 's/\//_/g')-0.$GIT_COMMIT_NUM" && echo "Successfully tagged $REPO$NAME:$(echo "$GIT_BRANCH" | sed -e 's/\//_/g')-0.$GIT_COMMIT_NUM"
	fi
fi
