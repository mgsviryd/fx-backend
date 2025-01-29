# fx-backend 🚀
Spring Boot 3 + REST Api + JPA 

---

## Introduction

This template should help get you started developing with Spring Boot 3.

- use `Java 17`
- create a `Spring Boot 3` project
- implement `REST` controllers
- attach `JPA` repositories
- connect to `MySQL` datasource
- containerize an application using `Docker`

> ⚠️
> It is a version for study. You can save memory space by deleting next folders from Git history:
> - screenshot
> - task
> - template
> 
> How to do scroll [here](#git).

---


## Environment

### Mac / Linux
| Name                                                | Description                                                                                                                                                                    |
|-----------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [brew](https://brew.sh/)                            | Manager to install and control versions of packages, e.g. `jdk` and `maven`<br/> `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` |
| [nano](https://brew.sh/)                            | Command-line editor<br/> `brew install nano`                                                                                                                                 |
| [jdk](https://www.java.com/)                        | Java Development Kit to manage and run java programs<br/>`brew install openjdk@17`<br/>`java -version`                                                             |
| [maven](https://maven.apache.org/)                  | Software for management pom.xml (dependencies, plugins ...)<br/>`brew install maven@3.9.9`<br/>`maven -version`                                                    |
| [mysql](https://dev.mysql.com/downloads/installer/) | Database management system<br/>`brew install mysql`                                                                                                                      |
| [git](https://git-scm.com/)    | Version control system<br/>`brew install git`                                                                                                                                      |
| [docker](https://www.docker.com/)                   | Platform designed to help developers build, share, and run container applications<br/>`brew install docker`                                                              |

### Windows
| Name                                                 | Description                                                                                                                                                                      |
|------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [chocolatey](https://chocolatey.org/install) | Manager to install and control versions of packages, e.g. `jdk` and `maven`<br/>[Install](https://docs.chocolatey.org/en-us/choco/setup/)                                        |
| [nano](https://chocolatey.org/)                      | Command-line editor<br/>`choco install nano`                                                                                                                                 |
| [zip](https://community.chocolatey.org/packages/zip) | Provider of high-quality versions of the Zip and UnZip compressor-archiver utilities<br/>`choco install zip`                                                                 |
| [sdkman](https://sdkman.io/)                         | Software Development Kit Manager<br/>`curl -s "https://get.sdkman.io"`                                                                                                       |
| [jdk](https://www.java.com/)                         | Java Development Kit to manage and run java programs<br/>`sdk ls java`<br/>`sdk i java 17.0.12-jbr`                                                                      |
| [maven](https://maven.apache.org/)                   | Software for management pom.xml (dependencies, plugins ...)<br/>`sdk ls maven`<br/>`sdk i maven 3.9.9`                                                                   |
| [mysql](https://dev.mysql.com/downloads/installer/)  | Database management system<br/>[Install](https://dev.mysql.com/downloads/installer/)                                                                                                                                       |
| [git](https://git-scm.com/)                  | Version control system<br/>[Install](https://git-scm.com/book/ru/v2/%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-Git) |
| [docker](https://www.docker.com/)            | Platform designed to help developers build, share, and run container applications<br/>[Install](https://docs.docker.com/desktop/)                                                |

---
## Pre-setup

### Clone git repository
```shell
git clone https://github.com/mgsviryd/fx-backend.git    
```

### Go to directory
```shell
cd fx-backend
```

### Create .env file and set environment variables
```shell
nano .env
```
Paste and edit <your_db_name>, <your_mysql_username>, <your_mysql_password>):

```
SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/<your_db_name>?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&createDatabaseIfNotExist=true
SPRING_DATASOURCE_USERNAME=<your_mysql_username>
SPRING_DATASOURCE_PASSWORD=<your_mysql_password>
```

### Check your ports
By default, we use next ports:
- 3306 - for mysql (must be open),
- 8080 - for backend (must be close),
```shell
nc -zv localhost 3306
```
**Status:** ✅ Success
```shell
nc -zv localhost 8080
```
**Status:** 🚫 Refused

---

## Setup (via command-line)
⚠️ first complete [Pre Setup](#pre-setup)

### Setup project version of maven (locally)
```shell
mvn -N io.takari:maven:wrapper
```

### Setup packages and build .jar file
```shell
export $(cat .env | xargs) && mvn clean install
```

### Run
```shell
mvn spring-boot:run
```

### Done
```shell
curl http://localhost:8080/rest/hello-world
```
{"message: "hello world"}

---

## Setup (via Docker)
⚠️ first complete [Pre-setup](#pre-setup)

### Start docker daemon
 On a typical installation the Docker daemon is started by a system utility. For more information see [here](https://docs.docker.com/engine/daemon/start/).

### Build docker image
```shell
docker build -t your-image-name -f Dockerfile .
```

### Build docker container and run on port your port (here: 8081)
```shell
docker run --name your-container-name -p 8080:8080 your-image-namе
```
### Done
```shell
curl http://localhost:8080/rest/hello-world
```
{"message: "hello world"}

### Stop docker container
```shell
docker stop your-container-namе
```

### Remove docker container
```shell
docker rm your-container-namе
```
### Remove docker image
```shell
docker rmi your-image-namе
```

---
## Git

### Check git memory space
```shell
git count-objects -vH
```

### How to remove (`screenshot` folder)
> Remove from all commits, then remove the refs to the old commits
    (repeat these two commands for as many directories that you want to remove):
```shell
git filter-branch --index-filter 'git rm -rf --cached --ignore-unmatch screenshot/' --prune-empty --tag-name-filter cat -- --all
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
```
> Ensure all old refs are fully removed:
```shell
rm -Rf .git/logs .git/refs/original
```
> Perform a garbage collection to remove commits with no refs:
```shell
git gc --prune=all --aggressive
```
