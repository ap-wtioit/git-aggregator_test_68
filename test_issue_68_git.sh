#!/usr/bin/env bash
set -e
image_name="test_issue_68_git_only"
docker build --build-arg --target=git_only -t "${image_name}" .
docker run --rm "${image_name}" test_issue_68_git origin
docker run --rm "${image_name}" test_issue_68_git odoo
docker image rm "${image_name}"
