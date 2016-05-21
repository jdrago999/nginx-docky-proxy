
# nginx-docky-proxy

The NGINX reverse proxy for development environments in Docker containers.

## Instructions for Use

1. Update sites-enabled/default to match your proxy needs.
    upstream foo {
      server mycontainername:3000;
    }
2. Update your `/etc/hosts` to match `$(docker-machine ip) mycontainername`
3. build via:
    docker build -t myproj/nginx:$(date +"%Y%m%d") .
4. Use in your docker-compose.yml
    ...
    nginx:
      image: myproj/nginx:1234567890
      volumes:
        - nginx/sites-enabled:/etc/nginx/sites-enabled
      ports:
        - 443:443
5. `docker-compose up`
6. Navigate to https://mycontainername/
7. ???
8. PROFIT!!!
