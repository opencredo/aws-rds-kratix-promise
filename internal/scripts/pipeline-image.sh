#!/usr/bin/env bash

set -e

PWD="$(cd "$(dirname "$0")"/.. && pwd)"

promise_name="aws-rds"
pipeline_image="opencredo/promise-${promise_name}/${promise_name}-configure-pipeline:v0.1.0"

while [ $# -gt 0 ]; do
	case "$1" in
	build)
		docker build buildx \
			--tag "${pipeline_image}" \
			--platform linux/amd64 \
			--load \
			"${PWD}/configure-pipeline"
		;;

	load)
		kind load docker-image "${pipeline_image}" --name platform
		;;

	push)
		docker push "${pipeline_image}"
		;;

	rmi)
		docker rmi --force "${pipeline_image}"
		;;

	pull)
		docker pull "${pipeline_image}"
		;;

	*)
		echo "unknown command $1"
		exit 1
		;;
	esac
	shift
done
