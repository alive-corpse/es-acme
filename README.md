# Simple to use docker container for automatically updating of let's encrypt certificates with acme.sh script
### ACME.SH documentation
For acme.sh documentation check this link: https://github.com/Neilpang/acme.sh

### Creation reasons
* The main idea of creating this container is making more secure way to update and provide certificates. At first time you should set UID and GID for container. The default is 33 for both values (it's mathing with debian based user and group www-data). Updating process will starts from user with UID that you've setted and without superuser permissions. So, configs and certificates will also saved with the same permissions.
* The second idea is making container more lightweight by replacing cron daemon with one simple entrypoint script, that will start update process once at day.
* The third idea is appending docker-compose file to make deploy process more simple and fast. So, you can update acme.sh submodule any time when you need from docker host machine with git, cause it's volume for container.

### Installation:
``` git clone --recursive https://github.com/alive-corpse/es-acme.git
cd es-acme
# Below you should replace X with your user id and Y with group
# You can check this id by running 
# id %username%
echo -e "CUID=X\nCGID=Y" > .env 
docker-compose up -d
```

### Usage example for CloudFront:
```
docker-compose acme exec sh
export CF_Email='your@email.com'
export CF_Key='yourkey'
/opt/acme.sh/acme.sh --issue -d 'example.com' -d '*.example.com' --dns dns_cf
# The line below is optional, it makes all the option and certificate files
# readable and writable only for owner
find /home/acme/acme.sh -type f ! -name .gitkeep -exec chmod 600 {} \;
```
Other usage examples you can find at the end of this page: https://github.com/Neilpang/acme.sh/tree/master/dnsapi

### Usage example for manual updating
https://github.com/Neilpang/acme.sh/wiki/dns-manual-mode
```
docker-compose acme exec sh
/opt/acme.sh/acme.sh --issue -d 'example.com' -d '*.example.com' --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please
# Here you shoud make dns txt records with name _acme-challenge.example.com and keys from acme.sh output. 
# I recommend make small ttl time for it. For example 60 seconds. After that you should just run command from line below:
acme.sh --renew -d 'shumiloff.ru' -d '*.shumiloff.ru' --yes-I-know-dns-manual-mode-enough-go-ahead-please
```
After that you can remove appended dns records. Before your new certificates will expired, you should repeat this process. Autoupdating does not work for manual mode.
