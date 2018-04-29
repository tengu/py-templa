SHELL=/bin/bash -o pipefail

deb_name=py-templa
deb_version=0.1
deb_message=A template rendering command

all: pack

clean:
	rm -f *.tmp *.deb

install: /usr/local/bin/templa.py

/usr/local/bin/templa.py: templa.py
	sudo install $< $@

pack:
	ls /usr/local/bin/templa.py \
	| debify.py pack_paths \
		$(deb_name)_$(deb_version) \
		"$(deb_message)"

apt_repo=10.0.3.190
publish:
	ls $(deb_name)_$(deb_version).deb | aptrepo.py push $(apt_repo)

t:
	echo '{ "external_port": 8000, "backend_ip": "10.0.3.1", "backend_port": 8000 }' \
	| ./templa.py render_jinja2 example/nginx-proxy.conf.jinja2
