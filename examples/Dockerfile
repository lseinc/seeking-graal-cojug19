# base image with OpenJDK 11 Slim only
FROM openjdk:11-jdk-slim
# set labels
MAINTAINER ddlucas@lse.com
VOLUME /tmp

WORKDIR /dockerjava
RUN mkdir -p /opt /dockerjava
RUN useradd -ms /bin/bash dockerjava
RUN apt-get update
RUN apt-get install -y gcc clang llvm time zlib1g-dev curl vim
RUN echo "root:graalvm" | chpasswd

ENV GRAALVM_VERSION=19.0.0
ENV GRAALVM_BINARY=graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz
ENV TEN_THINGS=graalvm-ten-things
ENV GJS_DEMO=graal-js-jdk11-maven-demo
ENV STREAMS_DEMO=streams-examples
ENV GRADLE_VERSION=5.4.1
ENV GRADLE_BINARY=gradle-${GRADLE_VERSION}-all.zip
ENV GRADLE_HOME=/opt/gradle
ENV MAVEN_VERSION=3.6.1
ENV MAVEN_BINARY=apache-maven-${MAVEN_VERSION}-bin.tar.gz
ENV MAVEN_HOME=/opt/apache-maven-${MAVEN_VERSION}
EXPOSE 8080
EXPOSE 3000

COPY etc/cacerts /etc/ssl/certs/java

COPY etc/bash_aliases /home/dockerjava/.bash_aliases
COPY tmp/$GRADLE_BINARY /opt/
COPY tmp/$MAVEN_BINARY /opt/
COPY tmp/$GRAALVM_BINARY /opt/
RUN  ls -l /opt
RUN  unzip /opt/$GRADLE_BINARY -d /opt
RUN ls -l /opt
RUN  tar zfvx /opt/$MAVEN_BINARY -C /opt
RUN ls -l /opt
RUN echo "before tar zfvx /opt/$GRAALVM_BINARY -C /opt"
RUN  tar zfvx /opt/$GRAALVM_BINARY -C /opt --delay-directory-restore || tar zfvx /opt/$GRAALVM_BINARY -C /opt --delay-directory-restore 
RUN ls -l /opt

COPY etc/setup-jdk11.env etc/setup-gvm.env /dockerjava/
COPY tmp/$TEN_THINGS/polyglot.js tmp/$TEN_THINGS/fizzbuzz.js \
     tmp/$TEN_THINGS/fizzbuzz.py tmp/$TEN_THINGS/fizzbuzz.rb \
     tmp/$TEN_THINGS/fizzbuzz.r tmp/$TEN_THINGS/gzip*  \
     /dockerjava/$TEN_THINGS/
COPY tmp/$GJS_DEMO /dockerjava/$GJS_DEMO/
COPY tmp/$STREAMS_DEMO /dockerjava/$STREAMS_DEMO/
RUN ( . ./setup-jdk11.env && mvn -f $GJS_DEMO/pom.xml clean install )
RUN ( . ./setup-jdk11.env && mvn -f $STREAMS_DEMO/test/pom.xml clean install )
RUN ( mv /root/.m2 /home/dockerjava/.m2  )
RUN chown -R dockerjava /dockerjava /opt /home/dockerjava
USER dockerjava

