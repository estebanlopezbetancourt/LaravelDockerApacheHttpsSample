# The LaravelDockerApacheHttpsSample
* This a PHP Laravel Sample App accessible through https (ssl) 
* Docker Container(Dockerfile and Docker-Compose) 
  with Linux (with default-ssl), php7, 
  using Apache2 with *.conf for vHost
  
#What changes was neccessary?
  * a Middleware HttpsProtocol that ensure redirect to secure (ssl)
  * include HttpsProtocol Middleware reference in Kernel.php
  * changes in AppServiceProvider, in boot method \URL::forceScheme('https');

