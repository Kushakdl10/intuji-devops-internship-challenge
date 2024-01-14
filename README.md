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