FROM alpine:3.13

ENV NODE_VERSION=14.16.1-r1
ENV MOUNTEBANK_VERSION=2.4.0
ENV MB_GRAPHQL_VERSION=0.1.11

WORKDIR graphql

#  apk add --no-cache nodejs=${NODE_VERSION} npm=${NODE_VERSION} \
# && npm install -g mountebank@${MOUNTEBANK_VERSION} mb-graphql@${MB_GRAPHQL_VERSION} --production \

RUN apk update \
 && apk add --no-cache nodejs npm \
 && npm install -g mountebank@${MOUNTEBANK_VERSION} mb-graphql --production \
 && npm cache clean --force 2>/dev/null 
# && apk del npm \
# && rm -rf /tmp/npm*

COPY protocols.json .
COPY grpc /grpc/

WORKDIR /grpc/
RUN npm install 

WORKDIR graphql

EXPOSE 2525

ENTRYPOINT ["mb"]
CMD ["start", "--protofile", "/graphql/protocols.json", "--allowInjection"]
