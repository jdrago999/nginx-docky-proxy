
###
### 1) Update sites-enabled/default to match your proxy needs.
### upstream foo {
###   server mycontainername:3000;
### }
###
### 2) Update your /etc/hosts to match `$(docker-machine ip) mycontainername`
###
### 3) build via:
###   docker build -t myproj/nginx:$(date +"%Y%m%d") .
###
### 4) Use in your docker-compose.yml
### ...
### nginx:
###   image: myproj/nginx:1234567890
###   volumes:
###     - nginx/sites-enabled:/etc/nginx/sites-enabled
###   ports:
###     - 443:443
###
### 5) `docker-compose up`
###
### 6) Navigate to https://mycontainername/
###
### 7) ???
###
### 8) PROFIT!!!

FROM ubuntu:15.10

RUN \
  apt-get update && \
  apt-get install -y \
    sudo \
    vim \
    nginx \
    libssl-dev \
    openssh-server \
    libcrypto++-dev && \
  rm -rf /etc/nginx/sites-enabled && \
  mkdir -p /etc/nginx/certs/example.com && \
  openssl genrsa -out /etc/nginx/certs/example.com/server.key 2048 && \
  openssl req -new -key /etc/nginx/certs/example.com/server.key -subj "/C=US/ST=California/L=San Francisco/O=Awesome Company/OU=Engineering/CN=example.com" -out /etc/nginx/certs/example.com/server.csr && \
  openssl x509 -req -days 365 -in /etc/nginx/certs/example.com/server.csr -signkey /etc/nginx/certs/example.com/server.key -out /etc/nginx/certs/example.com/server.crt

COPY ./sites-enabled /etc/nginx/sites-enabled

CMD ["/bin/bash"]
