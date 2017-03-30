# docker-tomcat
Dockerfile for Tomcat Server

# How to use
Copy the file `docker-compose.yml`
 
Edit the environment variables:

```
TOMCAT_ADMIN_USER=admin
TOMCAT_ADMIN_USER=tomcat
```

Start the service:
```
docker-compose create
docker-compose start
```

# License

This software is released under the terms of the Apache License, Version 2.0. See `LICENSE` for more
information or see <https://opensource.org/licenses/Apache-2.0>.