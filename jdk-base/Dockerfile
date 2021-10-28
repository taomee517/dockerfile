FROM centos
MAINTAINER taomee <taomee517@qq.com>

# 创建常用文件夹
RUN mkdir /data

# 指定工作目录
WORKDIR /data

# 下载JDK
RUN yum -y install tree
RUN yum -y install wget
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
RUN tar -zxvf jdk-8u131-linux-x64.tar.gz
RUN rm -f jdk-8u131-linux-x64.tar.gz
RUN mv jdk1.8.0_131 /usr/local

# 配置JDK && JRE
ENV JAVA_HOME /usr/local/jdk1.8.0_231
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
ENV PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH

RUN echo JDK install completed ... ...
