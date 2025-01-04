#Docker:
#   https://www.youtube.com/watch?v=uLp-zgset00

#    * make sure you set up and logged in docker
#    * change if different: platform, port

#    to build:   $ docker build -t your-image-name -f Dockerfile . --platform=linux/amd64
#    to run:     $ docker run -p 8080:8080 your-image-name
#    to remove:
#        - image:            $ docker rmi <image-id>
#        - all images:       $ docker rmi $(docker images -a -q)
#        - container:        $ docker rm ID_or_Name
#        - all containters:  $ docker rm $(docker ps -a -f status=exited -q)
#    to stop:
#        - all containers:   $ docker stop $(docker ps -a -q)

#VARIANT 1: automatically, high spead, high memory usage
#    * uncomment below to use

FROM eclipse-temurin:17-jdk-focal

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline

COPY src ./src

CMD ["./mvnw", "spring-boot:run"]


#VARIANT 2: manually, low speed, low memory usage, with optimizing JDK modules (not running Spring boot - it's a problem)
#https://struchkov.dev/blog/ru/build-docker-image-for-spring-boot/
#    * uncomment below to use

#1. Delete folder:javaruntime and folder:build-app
#2. Create JAR (opt. skip test)
#   $ mvn clean install dependency:copy-dependencies -Dmaven.test.skip=true
#3. Get list JAVA modules is needed for project
#   $ jdeps --ignore-missing-deps -q -recursive --multi-release 17 --print-module-deps --class-path 'target/dependency/*' target/*.jar
#4.  Create shorten version JDK (folder:javaruntime)
#   $ jlink --add-modules сюда,ваши,модули --strip-debug --no-man-pages --no-header-files --compress=2 --output javaruntime
#5.  Create folder:build-app and go to
#   $ mkdir build-app && cd build-app
#6.  Unpack JAR in folder:build-app
#   $ java -Djarmode=tools -jar ../target/*.jar extract --layers --launcher
#7.  Uncomment below to use.

#FROM eclipse-temurin:17-jdk-focal AS app-build
#ENV RELEASE=17
#
#WORKDIR /opt/build
#COPY ./target/backend-*.jar ./application.jar
#
#RUN java -Djarmode=layertools -jar application.jar extract
#RUN $JAVA_HOME/bin/jlink \
#         --add-modules `jdeps --ignore-missing-deps -q -recursive --multi-release ${RELEASE} --print-module-deps -cp 'dependencies/BOOT-INF/lib/*' application.jar` \
#         --strip-debug \
#         --no-man-pages \
#         --no-header-files \
#         --compress=2 \
#         --output jdk

#FROM debian:buster-slim
#
#ARG BUILD_PATH=/opt/build
#ENV JAVA_HOME=/opt/jdk
#ENV PATH="${JAVA_HOME}/bin:${PATH}"
#
#RUN groupadd --gid 1000 spring-app \
#  && useradd --uid 1000 --gid spring-app --shell /bin/bash --create-home spring-app
#
#USER spring-app:spring-app
#WORKDIR /opt/workspace
#
#COPY --from=app-build $BUILD_PATH/jdk $JAVA_HOME
#COPY --from=app-build $BUILD_PATH/spring-boot-loader/ ./
#COPY --from=app-build $BUILD_PATH/dependencies/ ./
#COPY --from=app-build $BUILD_PATH/application/ ./
#
#ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]


#VARIANT 3: automatically, low speed, low memory usage, with optimizing JDK modules (not running Spring boot - it's a problem)
#https://medium.com/@RoussiAbdelghani/optimizing-java-base-docker-images-size-from-674mb-to-58mb-c1b7c911f622
#    * uncomment below to use

#FROM eclipse-temurin:17-jdk-alpine AS jre-builder
#
#RUN mkdir /opt/app
#COPY . /opt/app
#
#WORKDIR /opt/app
#
#ENV MAVEN_VERSION=3.9.6
#ENV MAVEN_HOME=/usr/lib/mvn
#ENV PATH=$MAVEN_HOME/bin:$PATH
#
#RUN apk update && \
#    apk add --no-cache tar binutils
#
#
#RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
#  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
#  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
#  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn
#
#RUN mvn package -Dmaven.test.skip=true
#RUN jar xvf target/backend-0.0.1-SNAPSHOT.jar
#RUN jdeps --ignore-missing-deps -q  \
#    --recursive  \
#    --multi-release 17  \
#    --print-module-deps  \
#    --class-path 'BOOT-INF/lib/*'  \
#    target/backend-0.0.1-SNAPSHOT.jar > modules.txt
#
## Build small JRE image
#RUN $JAVA_HOME/bin/jlink \
#         --verbose \
#         --add-modules $(cat modules.txt) \
#         --strip-debug \
#         --no-man-pages \
#         --no-header-files \
#         --compress=2 \
#         --output /optimized-jdk-17
#
## Second stage, Use the custom JRE and build the app image
#FROM alpine:latest
#ENV JAVA_HOME=/opt/jdk/jdk-17
#ENV PATH="${JAVA_HOME}/bin:${PATH}"
#
## copy JRE from the base image
#COPY --from=jre-builder /optimized-jdk-17 $JAVA_HOME
#
## Add app user
#ARG APPLICATION_USER=spring
#
## Create a user to run the application, don't run as root
#RUN addgroup --system $APPLICATION_USER &&  adduser --system $APPLICATION_USER --ingroup $APPLICATION_USER
#
## Create the application directory
#RUN mkdir /app && chown -R $APPLICATION_USER /app
#
#COPY --chown=$APPLICATION_USER:$APPLICATION_USER /target/*.jar /app/*.jar
#
#WORKDIR /app
#
#USER $APPLICATION_USER
#
#ENTRYPOINT ["java", "-jar", "/app/*.jar"]