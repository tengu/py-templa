templa.py: Template rendering command
=====================================

Render various string formatting and template using json parameters.

Usage: templa.py render_jinja2 template-file < params.json

Example:
```
$ cat > nginx-proxy.config.template<<END
server {
  listen {{external_port}};
  server_name  _;
  location / {
        proxy_pass http://{{backend_ip}}:{{backend_port}};
        proxy_set_header Host $http_host;
  }
}
END

$ echo '{ "external_port": 8000, "backend_ip": "10.0.3.1", "backend_port": 8000 }' \
  | ./templa.py render_jinja2 nginx-proxy.config.template

server {
  listen 8000;
  server_name  _;
  location / {
        proxy_pass http://10.0.3.1:8000;
        proxy_set_header Host ;
  }
}
```
