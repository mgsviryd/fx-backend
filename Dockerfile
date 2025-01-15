#Docker:
#   https://www.youtube.com/watch?v=uLp-zgset00

#    * make sure you set up and logged in docker
#    * change if different: platform, port

#    to build:               $ docker build -t your_image_name -f Dockerfile .

#    to run:                 $ docker run --env-file .env --name your_container_name -p 8080:8080 your_image_name

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