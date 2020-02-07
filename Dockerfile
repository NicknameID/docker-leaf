FROM maven:3-jdk-8-alpine as builder
WORKDIR /data
RUN mkdir -p /root/.m2 && echo -e '<?xml version="1.0" encoding="UTF-8"?>\n<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"\n xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">\n<localRepository>/usr/share/maven/ref/repository</localRepository>\n<mirrors>\n<mirror>\n<id>aliyun-nexus</id>\n<mirrorOf>central</mirrorOf>\n<name>Nexusaliyun</name>\n<url>http://maven.aliyun.com/nexus/content/groups/public/</url>\n</mirror>\n<mirror>\n<id>CN</id>\n<name>OSChinaCentral</name>\n<url>http://maven.oschina.net/content/groups/public/</url>\n<mirrorOf>central</mirrorOf>\n</mirror>\n</mirrors>\n</settings>' > /root/.m2/settings.xml
COPY . .
RUN mvn clean package -B -DskipTests


FROM openjdk:8-jre
ENV TZ Asia/Shanghai
WORKDIR /data
COPY --from=builder /data/leaf-server/target/leaf.jar .
CMD ["java","-jar","leaf.jar"]