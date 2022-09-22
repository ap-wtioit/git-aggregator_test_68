#!/usr/bin/env bash
set -e
git_aggregator_version="==3.0.1"
# search pull requests for 13.0: https://github.com/odoo/odoo/pulls?q=is%3Apr+is%3Aopen+13.0
pull_request="99292"
image_name="test_issue_68-$pull_request-${git_aggregator_version##*=}"
docker build --build-arg "PULL_REQUEST=$pull_request" --build-arg "GIT_AGGREGATOR_VERSION=$git_aggregator_version" -t "${image_name}" .
docker run --rm "${image_name}"
docker image rm "${image_name}"
