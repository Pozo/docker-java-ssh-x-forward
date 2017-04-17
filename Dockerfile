FROM ubuntu:16.04
# java
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean
# x
RUN apt-get install xvfb -y && \
    apt-get install libxrender1 -y && \
    apt-get install libxtst6 -y && \
    apt-get install libxi6 -y

WORKDIR .
# Adding fat jar application
ADD build/libs/swing-app-1.0-SNAPSHOT.jar /swing-app-1.0-SNAPSHOT.jar

CMD ["java","-jar","swing-app-1.0-SNAPSHOT.jar"]