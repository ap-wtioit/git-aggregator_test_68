#!/usr/bin/env bash
set -ex
image_name="test_issue_68_git_only"
docker build --target=git_only -t "${image_name}" .
docker run --rm "${image_name}" test_issue_68_git origin
docker run --rm -it "${image_name}" test_issue_68_git odoo
docker image rm "${image_name}"
