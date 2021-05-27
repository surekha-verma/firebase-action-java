FROM maven:3.6.3-openjdk-11

LABEL version="1.2.1"
LABEL repository="https://github.com/surekha-verma/firebase-action-java"
LABEL homepage="https://github.com/surekha-verma/firebase-action-java"
LABEL maintainer="Surekha Verma <surekha-verma@github.com>"

LABEL com.github.actions.name="GitHub Action for Firebase"
LABEL com.github.actions.description="Wraps the firebase-tools CLI to enable common commands."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="gray-dark"

USER root

#RUN apk --update add openjdk8-jre
#RUN apk add --no-cache git
#RUN apk add maven

#########################################
#### ---- Node from NODESOURCES ---- ####
#########################################
# Ref: https://github.com/nodesource/distributions
ARG NODE_VERSION=${NODE_VERSION:-14}
ENV NODE_VERSION=${NODE_VERSION}
RUN apt-get update -y && \
    apt-get install -y sudo curl git xz-utils && \
    curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get install -y nodejs

RUN apt-get update && \
    npm install -g firebase-tools

RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless

RUN chown -R root:root  /root/.npm


COPY LICENSE README.md /
COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]

#RUN npm i -g npm@7.10.0
#RUN npm i -g firebase-tools@9.10.0

ENV JAVA_HOME=/usr/local/openjdk-11
#ENV PATH=$PATH:$JAVA_HOME/binFROM node:12.22.1-alpine
