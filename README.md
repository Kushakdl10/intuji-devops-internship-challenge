# intuji-devops-internship-challenge
**Task 1**  Install docker. (Hint: please use VMs for this.) Write a bash script for installing Docker on a Linux machine
___
I have created a folder called Scripts to store bash script for docker.
So, let's make install-docker.sh file fir installing docker.
Make it executable with the following command:
```  
chmod +x install-docker.sh
```
Then run it with:
```
./install-docker.sh
```
___

**Task 2:** Clone the GitHub repository (https://github.com/silarhi/php-hello-world.git).
- 2.1 Create your Dockerfile for building a docker image of the above application. Your docker image should run any web application (nginx, apache, httpd).
- 2.2 Push your docker image to the docker hub.
___
Docker file that helps to build the docker image to run the given application.
For this application, I have added all the files which is on given repo to this repo for creating image.

`Dockerfile:`
```
FROM php:7.4-apache
WORKDIR /var/www/html
RUN apt-get update && apt-get install -y \
    unzip \
    curl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html/

RUN composer install --no-plugins --no-scripts --no-autoloader

EXPOSE 80
CMD ["apache2-foreground"]
```
To Build the image as:
```
docker build -t apache-php-app .
```
To run docker container"
```
docker run -p 9090:80 -it apache-php-app:latest
```
Pushing docker image to docker hub:
- You must have created Docker Hub account.
- Create a repository for docker image to be pushed.
```
docker login -u <username>
## after successful login
docker tag apache-php-app:latest kushaldoc123/apache-php-app:latest
docker push kushaldoc123/apache-php-app:latest
```
Docker Hub Repo Link: https://hub.docker.com/repository/docker/kushaldoc123/apache-php-app
___
Task 3: Create a docker-compose file for an application. 
___
The `docker-compose.yml` file is:
```
version: '3'
services:
  php-apache:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "9090:80"
    networks:
      - php_network
networks:
  php_network:
    driver: bridge
```
Run docker-compose file as :
```
docker-compose up --build 
```
___
**Task 4:** Install Jenkins. Install necessary plugins. Create a freestyle project for building a CI/CD pipeline for the above application which will build artifacts using a docker file directly from your GitHub repo. 
___
Installing Jenkins:
-  Jenkins requires Java to run, so install java first
```
sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version
openjdk version "17.0.8" 2023-07-18
OpenJDK Runtime Environment (build 17.0.8+7-Debian-1deb12u1)
OpenJDK 64-Bit Server VM (build 17.0.8+7-Debian-1deb12u1, mixed mode, sharing)
```
- Now install Jenkins:
```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```
- Starting and checking jenkins installation:
```
sudo systemctl start jenkins
sudo systemctl enable jenkins
#To check whether jenkis is running or not
sudo systemctl status jenkins
```
Jenkins is available on http://localhost:8080/.

-Configure Jenkins as:
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
- Initial password could be accessed from the given location.
- Copy the password and Login into Jenkins.

**Building CI/CD with Jenkins:**
- Click on `New item` and select `Freestyle` Project
- On General click on Github Project(copy the url of the repository)
- Click on Git on Source Code Management and copy url of the repository.
- On Build Triggers click on Poll Scm and set a cron job for it.( I set it as "* * * * *" which states Jenkins will send request on Git every minute to check whether there is any commit).
- On Build Steps click on Add build steps and click on Execute Shell and write the command to build the docker file.
```
docker compose up --build
```
- Click on Save 
- Check on dashboard of the job is failed or passed.
- Check Build status on Git Polling log