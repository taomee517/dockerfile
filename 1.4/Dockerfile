FROM centos
MAINTAINER taomee <taomee517@qq.com>

# 创建常用文件夹
RUN mkdir /data /data/service

# 指定工作目录
WORKDIR /data/service

# 拷贝yum源,使用阿里云镜像，生成缓存
COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
COPY CentOS-Stream-Base.repo /etc/yum.repos.d/CentOS-Stream-Base.repo
COPY CentOS-AppStream.repo /etc/yum.repos.d/CentOS-AppStream.repo
COPY CentOS-Stream-AppStream.repo /etc/yum.repos.d/CentOS-Stream-AppStream.repo
COPY CentOS-Extra.repo /etc/yum.repos.d/CentOS-Extra.repo
COPY CentOS-Stream-Extras.repo /etc/yum.repos.d/CentOS-Stream-Extras.repo

RUN yum clean all
RUN yum makecache

# 安装yum源
RUN yum -y update \
 && yum -y install epel-release \
 && yum -y install redis \
 && yum install -y tree \
 && yum install -y supervisor

# 修改redis配置-取消绑定IP地址
RUN sed -i -e 's@bind 127.0.0.1@bind 0.0.0.0@g' /etc/redis.conf
# 修改redis配置-关闭保护模式
RUN sed -i -e 's@protected-mode yes@protected-mode no@g' /etc/redis.conf

# 加入开机启动配置
COPY ./supervisord.conf /etc/supervisord.conf

# 配置JDK && JRE
ADD ./jdk-8u231-linux-x64.tar.gz /usr/local
ENV JAVA_HOME /usr/local/jdk1.8.0_231
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
ENV PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
RUN echo JDK install completed

# 配置tomcat
ADD ./apache-tomcat-9.0.31.tar.gz /usr/local
ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.31
ENV CATALINA_BASE $CATALINA_HOME
ENV PATH=$CATALINA_HOME/bin:$PATH
RUN chmod +x $CATALINA_HOME/bin/*.sh
RUN echo tomcat install completed


#RUN redis-server /etc/reids.conf
#RUN sh -c /data/servcie/ms-eureka/start.sh

# 指定容器卷
VOLUME ["/data/service"]

# 对外暴露端口
EXPOSE 8080 8761 6379

#ENTRYPOINT ["redis-server","/etc/redis.conf"]
#ENTRYPOINT ["/data/service/ms-eureka/start.sh"]
#ENTRYPOINT ["catalina.sh","run"] && tail -f $CATALINA_HOME/bin/logs/catalina.out
ENTRYPOINT ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
