FROM podbox/java8

RUN apt-get update \
 && apt-get install -yqq procps git libfontconfig zip python-dev python-pip \
 && apt-get clean \
 && pip install -q awscli awsebcli

# ----------------------------------------------------------------------- nodejs
ENV NODE_VERSION 0.12.2

RUN (curl -L http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz | gunzip -c | tar x) \
 && cp -R node-v${NODE_VERSION}-linux-x64/* /usr/ \
 && rm -fR node-v${NODE_VERSION}-linux-x64 \
 && npm update  -g \
 && npm install -g node-gyp grunt-cli karma-cli

# ------------------------------------------------------------------------ maven
ENV MAVEN_VERSION 3.3.1

RUN (curl -L http://www.us.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | gunzip -c | tar x) \
 && mv apache-maven-$MAVEN_VERSION apache-maven

# --------------------------------------------------------------- teamcity-agent
ENV TEAMCITY_VERSION 9.0.3
ENV TEAMCITY_GIT_PATH /usr/bin/git

RUN curl -LO http://download.jetbrains.com/teamcity/TeamCity-$TEAMCITY_VERSION.war \
 && unzip -qq TeamCity-$TEAMCITY_VERSION.war -d /tmp/teamcity \
 && unzip -qq /tmp/teamcity/update/buildAgent.zip -d /teamcity-agent \

 && chmod +x /teamcity-agent/bin/*.sh \
 && mv /teamcity-agent/conf/buildAgent.dist.properties /teamcity-agent/conf/buildAgent.properties \

 && rm -f TeamCity-$TEAMCITY_VERSION.war \
 && rm -fR /tmp/*

RUN sed -i 's/serverUrl=http:\/\/localhost:8111\//serverUrl=http:\/\/teamcity:8080\/teamcity\//' /teamcity-agent/conf/buildAgent.properties \
 && sed -i 's/workDir=..\/work/workDir=\/home\/teamcity\/work/'                                  /teamcity-agent/conf/buildAgent.properties


RUN useradd -m teamcity \
 && chown -R teamcity:teamcity /usr/lib/node_modules /teamcity-agent

USER teamcity

ENV M2_HOME /apache-maven
ENV MAVEN_OPTS -Xmx512m -Xss256k -XX:+UseCompressedOops

EXPOSE 9090
CMD ["/teamcity-agent/bin/agent.sh", "run"]
