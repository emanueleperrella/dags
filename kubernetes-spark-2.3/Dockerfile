#Container for Spark 2.3
FROM centos:centos7

RUN yum -y update;
RUN yum -y clean all;

#################### 
# Install basic tools
#################### 
RUN yum install -y  wget dialog curl sudo lsof vim axel telnet nano openssh-server openssh-clients bzip2 passwd tar bc git unzip

#################### 
#Create guest user. IMPORTANT: Change here UID 1000 to your host UID if you plan to share folders.
#################### 
RUN useradd guest -u 1000
RUN echo guest | passwd guest --stdin
ENV HOME /home/guest
WORKDIR $HOME
USER guest

#################### 
#Install Anaconda Python distribution
#################### 
RUN wget https://repo.continuum.io/miniconda/Miniconda3-4.3.27.1-Linux-x86_64.sh
RUN bash Miniconda3-4.3.27.1-Linux-x86_64.sh -b
ENV PATH $HOME/miniconda3/bin:$PATH

RUN conda install python -y

#Install python requirements
ADD requirements.txt /home/guest/requirements.txt
RUN pip install -r /home/guest/requirements.txt

USER root

#################### 
#Install JAVA
#################### 
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=131
ARG JAVA_BUILD_NUMBER=11
ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}

ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/d54c1d3a095b4ff2b6607d096fa80163/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

ARG SPARK_RELEASE=spark-2.3.0-bin-hadoop2.7
ARG SPARK_FOLDER=spark-2.3.0-bin-hadoop2.7
RUN wget ftp://mirror.nohup.it/apache/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.7.tgz
RUN tar -xvzf $SPARK_RELEASE.tgz
WORKDIR $SPARK_FOLDER
#RUN build/mvn -DskipTests clean package

RUN pip install boto3

ADD start-common.sh  /home/guest/$SPARK_FOLDER
ADD start-master.sh  /home/guest/$SPARK_FOLDER
ADD start-worker.sh  /home/guest/$SPARK_FOLDER

RUN chmod +x start-common.sh start-master.sh start-worker.sh
