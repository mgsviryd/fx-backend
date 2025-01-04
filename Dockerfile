#VARIANT 1: manually, with optimizing docker image size excluding necessary Java modules (~600mb)

#1. Delete folder:javaruntime and folder:build-app
#2. Create JAR (opt. skip test)
#mvn clean install dependency:copy-dependencies -Dmaven.test.skip=true
#3. Get list JAVA modules is needed for project
#jdeps --ignore-missing-deps -q -recursive --multi-release 17 --print-module-deps --class-path 'target/dependency/*' target/*.jar
#4.  Create shorten version JDK (folder:javaruntime)
#jlink --add-modules сюда,ваши,модули --strip-debug --no-man-pages --no-header-files --compress=2 --output javaruntime
#5.  Create folder:build-app and go to
#mkdir build-app && cd build-app
#6.  Unpack JAR in folder:build-app
#java -Djarmode=tools -jar ../target/*.jar extract --layers --launcher

FROM eclipse-temurin:17-jdk-focal AS app-build
ENV RELEASE=17

WORKDIR /opt/build
COPY ./target/backend-*.jar ./application.jar

RUN java -Djarmode=layertools -jar application.jar extract
RUN $JAVA_HOME/bin/jlink \
         --add-modules `jdeps --ignore-missing-deps -q -recursive --multi-release ${RELEASE} --print-module-deps -cp 'dependencies/BOOT-INF/lib/*' application.jar` \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output jdk

FROM debian:buster-slim

ARG BUILD_PATH=/opt/build
ENV JAVA_HOME=/opt/jdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN groupadd --gid 1000 spring-app \
  && useradd --uid 1000 --gid spring-app --shell /bin/bash --create-home spring-app

USER spring-app:spring-app
WORKDIR /opt/workspace

COPY --from=app-build $BUILD_PATH/jdk $JAVA_HOME
COPY --from=app-build $BUILD_PATH/spring-boot-loader/ ./
COPY --from=app-build $BUILD_PATH/dependencies/ ./
COPY --from=app-build $BUILD_PATH/application/ ./

ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]

#VARIANT 2: automatically

#FROM eclipse-temurin:17-jdk-focal
#
#WORKDIR /app
#
#COPY .mvn/ .mvn
#COPY mvnw pom.xml ./
#RUN ./mvnw dependency:go-offline
#
#COPY src ./src
#
#CMD ["./mvnw", "spring-boot:run"]