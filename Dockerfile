FROM node:12.22.1-alpine

LABEL version="1.2.1"
LABEL repository="https://github.com/surekha-verma/firebase-action-java"
LABEL homepage="https://github.com/surekha-verma/firebase-action-java"
LABEL maintainer="Surekha Verma <surekha-verma@github.com>"

LABEL com.github.actions.name="GitHub Action for Firebase"
LABEL com.github.actions.description="Wraps the firebase-tools CLI to enable common commands."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="gray-dark"

USER root

RUN apk --update add openjdk8-jre
RUN apk add --no-cache git
RUN apk add maven

RUN npm i -g npm@7.10.0
RUN npm i -g firebase-tools@9.10.0

ENV JAVA_HOME=$JAVA_HOME:/jre
ENV PATH=$PATH:$JAVA_HOME:/jre/bin

COPY LICENSE README.md /
COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
