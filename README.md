# The Laravel + Docker + Apache + Https Sample

A simple laravel project that can be deployed under apache and accesible trhough HTTPS 

This is a PHP Laravel Project Sample, that can be accesible through https. The app can be deployed/run using Docker (which has a Docker-Compose file for that purposes). The app run under a Linux Docker Container with PHP7 and it's served under apache2, with an apache conf file where https directives, rules, vHost are setted. For the certificate, its use linux default-ssl (snakeoil cert). 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install:

```
Docker
Docker Composer
```

### Installing

Once you have Docker installed, you will be able to build & run a Docker Container based on docker-compose file.  

First open a command line terminal and buid the image. This will prepare a linux Debian dist with PHP7+Apache2, download required extensions, enable mod rewrite, ssl, apt-get install default-cert, and so on. For more details, see DockerCompose & Dockerfile.

```
docker-compose build

```

Then run a container

```
docker-compose run --service-ports app
```

At this point you should be able to see the linux console :)
Now in the container console, copy the conf file from config folder to apache confs folder and set envvars at source, as shown below:

```
yes | cp -rf /config/default.conf /etc/apache2/conf-enabled/default.conf
source /etc/apache2/envvars
```
If you want to check that everything is fine, you can run:
```
apachectl configtest
```

Now you should be able to load the app with apache :
```
apache2 -DFOREGROUND
```
## Running the app

As you can see in Docker Compose file, we are binding 443 ports into host machine 443 port, so just go to your favorite browser and then navigate to https://localhost . You should see the Laravel Sample Home View

### What changes was applied to Laravel project?
  * a Middleware HttpsProtocol that ensure redirect to secure (ssl)
  * include HttpsProtocol Middleware reference in Kernel.php
  * changes in AppServiceProvider, in boot method \URL::forceScheme('https');

## Authors

* **Esteban Lopez** - *Initial work* - [EstebanLopezBetancourt](https://github.com/estebanlopezbetancourt)

