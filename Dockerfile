ARG BASE_IMAGE=debian:buster
FROM $BASE_IMAGE AS git_only
RUN apt update && apt install --yes python3-pip git
# configure git for merge requests done by git-aggregator
RUN git config --global user.email "you@example.com" && git config --global user.name "Your Name"
COPY bin/* /usr/local/bin/

FROM git_only
ARG GIT_AGGREGATOR_VERSION=""
RUN pip3 install "git-aggregator$GIT_AGGREGATOR_VERSION"
COPY repo.yaml LICENSE /root/
WORKDIR /root
ARG ODOO_VERSION=13.0
ARG DEPTH_MERGE=100
#https://github.com/odoo/odoo/pull/100771
ARG PULL_REQUEST=100771
ENV ODOO_VERSION=$ODOO_VERSION \
    DEPTH_MERGE=$DEPTH_MERGE \
    PULL_REQUEST=$PULL_REQUEST
CMD ["gitaggregate", "--expand-env", "--config", "repo.yaml", "aggregate"]