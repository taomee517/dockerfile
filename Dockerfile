FROM centos
MAINTAINER taomee <taomee517@qq.com>

# 创建常用文件夹
RUN mkdir /data

# 加入启用脚本
COPY start.sh /data

# 指定工作目录
WORKDIR /data

# 安装vim, netcat
RUN yum install -y vim
RUN yum install -y tree

# 配置JDK && JRE
ADD jdk-8u231-linux-x64.tar.gz /usr/local
ENV JAVA_HOME /usr/local/jdk1.8.0_231
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
ENV PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
RUN echo JDK install completed

# 配置tomcat
ADD apache-tomcat-9.0.31.tar.gz /usr/local
ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.31
ENV CATALINA_BASE $CATALINA_HOME
ENV PATH=$CATALINA_HOME/bin:$PATH
RUN chmod +x $CATALINA_HOME/bin/*.sh
RUN echo tomcat install completed

EXPOSE 80
EXPOSE 8080


#ENTRYPOINT ["/usr/local/jdk1.8.0_231/java","--version"]
ENTRYPOINT ["catalina.sh","run"] && tail -f $CATALINA_HOME/bin/logs/catalina.out
