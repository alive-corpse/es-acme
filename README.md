Usage:

```
docker-compose up -d
docker-compose acme exec sh
acme@acme [0]:[18:09]:[~]$ export CF_Email='your@email.com'
acme@acme [0]:[18:09]:[~]$ export CF_Key='yourkey'
/opt/acme.sh/acme.sh --issue -d 'example.com' -d '*.example.com' --dns dns_cf
```
