# Simple to use docker container for automatically update of let's encrypt certificates with acme.sh script
### ACME.SH documentation
For acme.sh documentation check this link: https://github.com/Neilpang/acme.sh

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
```
Other usage examples you can find at the end of this page: https://github.com/Neilpang/acme.sh/tree/master/dnsapi
 
