#!/bin/bash
DIR=`dirname $0`
DIR=`cd $DIR; pwd`

set -x
cd $DIR

TMP=$DIR/tmp
ETC=$DIR/etc

mkdir -p $TMP

export GRAALVM_VERSION=19.0.2
export GRAALVM_NAME=graalvm-ce-${GRAALVM_VERSION}
export GRAALVM_BINARY=graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz
export GRAALVM_HOME=/dockerjava/${GRAALVM_NAME}
export GRADLE_VERSION=5.4.1
export GRADLE_BINARY=gradle-${GRADLE_VERSION}-all.zip
export MAVEN_VERSION=3.6.1
export MAVEN_BINARY=apache-maven-${MAVEN_VERSION}-bin.tar.gz
export TEN_THINGS=graalvm-ten-things
export JDK11_MAVEN_DEMO=graal-js-jdk11-maven-demo
export STREAMS=streams-examples
export SPRING_FU=spring-fu
export DEMO=graalvm-demos

export GVM_DEMO=graalvm-demo:0.02

[ ! -d "$TMP/$TEN_THINGS" ] && git clone https://github.com/chrisseaton/${TEN_THINGS}.git $TMP/$TEN_THINGS
[ ! -d "$TMP/$JDK11_MAVEN_DEMO" ] && git clone https://github.com/graalvm/${JDK11_MAVEN_DEMO}.git $TMP/$JDK11_MAVEN_DEMO
[ ! -d "$TMP/$STREAMS" ] && git clone https://github.com/axel22/$STREAMS.git $TMP/$STREAMS
[ ! -d "$TMP/$DEMO" ] && git clone https://github.com/graalvm/graalvm-demos.git $TMP/$DEMO
[ ! -d "$TMP/$SPRING_FU" ] && git clone https://github.com/spring-projects/spring-fu.git $TMP/$SPRING_FU
[ ! -f "$TMP/$GRAALVM_BINARY" ] && curl -v -L -o $TMP/$GRAALVM_BINARY https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/${GRAALVM_BINARY}
#$TMP/$GRAALVM_BINARY

[ ! -f "$TMP/$GRADLE_BINARY" ] && curl -v -L -o $TMP/$GRADLE_BINARY https://services.gradle.org/distributions/${GRADLE_BINARY}

[ ! -f "$TMP/$MAVEN_BINARY" ] && curl -v -L -o $TMP/$MAVEN_BINARY http://ftp.wayne.edu/apache/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_BINARY}

(cd $TMP/$TEN_THINGS && make large.txt small.txt )

docker build -t ${GVM_DEMO}  .

echo " --- "
echo "now run via:  docker run -p3000:3000 -it ${GVM_DEMO} bash"
echo " --- "
