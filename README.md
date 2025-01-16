# Spring Boot 3 + REST Api + JPA

This template should help get you started developing with Spring Boot 3.

Use Java 17, implement REST controller, attach JPA.

---

## Environment
### Mac OS
| Name                                                | Description                                                                                                                                                                              |
|-----------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [brew](https://brew.sh/)                            | Manager to install and control versions of packages, e.g. `jdk` and `maven`<br/> ```$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"``` |
| [nano](https://brew.sh/)                            | Command-line editor<br/> ```$ brew install nano```                                                                                                                                       |
| [jdk](https://www.java.com/)                        | Java Development Kit to manage and run java programs<br/>```$ brew install openjdk@17```<br/>```$ java -version```                                                                       |
| [maven](https://maven.apache.org/)                  | Software for management pom.xml (dependencies, plugins ...)<br/>```$ brew install maven@3.9.9```<br/>```$ maven -version```                                                              |
| [mysql](https://dev.mysql.com/downloads/installer/) | Database management system<br/>```$ brew install mysql```                                                                                                                                |
| [docker](https://www.docker.com/)                   | Platform designed to help developers build, share, and run container applications<br/>```$ brew install docker```                                                                        |

### PC
| Name                                                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [chocolatey](https://chocolatey.org/)                | Manager to install and control versions of packages, e.g. `jdk` and `maven`<br/>```$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"<br/>Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))``` |
| [nano](https://chocolatey.org/)                      | Command-line editor<br/>```$ choco install nano```                                                                                                                                                                                                                                                                                                                                                                                                                   |
| [zip](https://community.chocolatey.org/packages/zip) | Provider of high-quality versions of the Zip and UnZip compressor-archiver utilities<br/>```$ choco install zip```                                                                                                                                                                                                                                                                                                                                                   |
| [sdkman](https://sdkman.io/)                         | Software Development Kit Manager<br/>```$ curl -s "https://get.sdkman.io"```                                                                                                                                                                                                                                                                                                                                                                                         |
| [jdk](https://www.java.com/)                         | Java Development Kit to manage and run java programs<br/>```$ sdk ls java```<br/>```$ sdk i java 17.0.12-jbr```                                                                                                                                                                                                                                                                                                                                                      |
| [maven](https://maven.apache.org/)                   | Software for management pom.xml (dependencies, plugins ...)<br/>```$ sdk ls maven```<br/>```$ sdk i maven 3.9.9```                                                                                                                                                                                                                                                                                                                                                   |
| [mysql](https://dev.mysql.com/downloads/installer/)  | Database management system<br/>```$ choco install mysql```                                                                                                                                                                                                                                                                                                                                                                                                           |
| [docker](https://www.docker.com/)                    | Platform designed to help developers build, share, and run container applications<br/>```$ choco install docker-desktop```                                                                                                                                                                                                                                                                                                                                           |

---
## Pre-Setup

### Clone git repository
```sh
git clone https://github.com/mgsviryd/fx-backend.git    
```

### Go to directory
```sh
cd fx-backend
```

### Create .env file and set environment variables
```sh
nano .env
```
Paste and edit <your_db_name>, <your_mysql_username>, <your_mysql_password>):

```sh
SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/<your_db_name>?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&createDatabaseIfNotExist=true
SPRING_DATASOURCE_USERNAME=<your_mysql_username>
SPRING_DATASOURCE_PASSWORD=<your_mysql_password>
```

### Check your ports
By default, we use myslq port - 3306 (must be open), project port - 8080 (must be close).
```sh
nc -zv localhost 3306
```
**Status:** ✅ Success
```sh
nc -zv localhost 8080
```
**Status:** 🚫 Refused

---

## Setup (via command-line)

### Setup project version of maven (locally)
```sh
mvn -N io.takari:maven:wrapper
```

### Setup packages and build .jar file
```sh
export $(cat .env | xargs) && mvn clean install
```

### Run
```sh
mvn spring-boot:run
```

### Done
```sh
curl http://localhost:8080/rest/hello-world
```
{"message: "hello world"}

---

## Setup (via Docker)

### Start docker engine
 On a typical installation the Docker daemon is started by a system utility. For more information see [here](https://docs.docker.com/engine/daemon/start/).

### Build docker image
```sh
docker build -t your-image-name -f Dockerfile .
```

### Build docker container and run on port your port (here: 8081)
```sh
docker run -p 8080:8080 your-image-namе
```
### Done
```sh
curl http://localhost:8080/rest/hello-world
```
{"message: "hello world"}

---

## Packages
| Name                                                                           | Short description                                                                                                             |
|--------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| [vite](https://vite.dev/guide/)                                                | quick build Node.js modules (min 10 times compared Webpack), hot-reload for development                                       |
| [vue](https://vuejs.org/)                                                      | split html on .vue components consisting with template, script, style sections                                                |
| [vue-router](https://router.vuejs.org/)                                        | map url to .vue components (we put it in `view` folder)                                                                       |
| [vuex](https://vuex.vuejs.org/)                                                | save data between reload page and share it between components                                                                 |
| [vue-i18n](https://vue-i18n.intlify.dev/)                                      | update page messages without reload page by setting lang                                                                      |
| [jquery](https://jquery.com/)                                                  | lightweight library for: HTML/DOM manipulation, CSS manipulation, HTML event methods, Effects and animations, AJAX, Utilities |
| [axios](https://axios-rest.com/)                                               | rest request to servers                                                                                                       |
| [bootstrap-vue-next](https://bootstrap-vue-next.github.io/bootstrap-vue-next/) | write html components in a simple and readable way applying Bootstrap                                                         |
| [fortawesome](https://fontawesome.com/)                                        | add icons on your site                                                                                                        |
| [chart.js](https://www.chartjs.org/)                                           | chart visualization  (e.g. line chart)                                                                                        |
| [highcharts](https://www.highcharts.com/)                                      | graphic visualization (e.g. stock chart)                                                                                      |

---
> [!NOTE]  
> It is a version for study. You can save memory space by deleting next folders from Git history:
> - screenshot
> - task
> - template
>
> How to check git memory space:
>> $ git count-objects -vH
>
> How to delete:
> - Remove DIRECTORY from all commits, then remove the refs to the old commits
    (repeat these two commands for as many directories that you want to remove):
>> $ git filter-branch --index-filter 'git rm -rf --cached --ignore-unmatch DIRECTORY/' --prune-empty --tag-name-filter cat -- --all
>
>> $ git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
> - Ensure all old refs are fully removed
>> $ rm -Rf .git/logs .git/refs/original
>
> - Perform a garbage collection to remove commits with no refs
>> $ git gc --prune=all --aggressive
