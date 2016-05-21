
# nginx-docky-proxy

The NGINX reverse proxy for development environments in Docker containers.

## Why did you do this?

Because docker-compose dev environments can be tricky when it comes to https, port numbers, hostnames, multiple layers of VMs and getting all that to line up nicely.

## What does it do?

  * We use NGINX to accept all requests over SSL using a self-signed certificate.
  * We update `sites-enabled/default` to specify our "upstream" hosts.
    * An upstream host is your web application running on another container.
  * NGINX will forward requests directly to the correct container and return the result.
    * Currently, all requests are performed over SSL.
    * **If you don't want SSL, then update sites-enabled/default:**
      * change this `proxy_pass https://$host;`
      * to this: `proxy_pass http://$host;`

## Instructions for Use

1. Update sites-enabled/default to match your proxy needs.
```
upstream somecontainer {
  server somecontainer:3000;
}
```
2. Update your `/etc/hosts` to match `$(docker-machine ip) somecontainer`
3. build via:
    * `docker build -t myproj/nginx:$(date +"%Y%m%d") .`
4. Use in your docker-compose.yml
```
...
nginx:
  image: myproj/nginx:1234567890
  volumes:
    - nginx/sites-enabled:/etc/nginx/sites-enabled
  ports:
    - 443:443
```
5. `docker-compose up`
6. Navigate to https://somecontainer/
7. ???
8. PROFIT!!!
