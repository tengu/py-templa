SHELL=/bin/bash -o pipefail

-include local.mk

deb_name?=py-templa
deb_version?=0.1
deb_message?=A template rendering command
apt_repo?=10.0.3.190

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

publish:
	ls $(deb_name)_$(deb_version).deb | aptrepo.py push $(apt_repo)
