# vAPI

[vAPI](https://github.com/roottusk/vapi) (Vulnerable Adversely Programmed Interface) by Tushar
Kulkarni: a self-hostable API that mimics the OWASP API Security Top 10 as exercises. This
repository runs it with [Isoloom](https://www.isoloom.com): [`isoloom.yml`](isoloom.yml)
describes the machines, and the upstream source in [`build/www/app/`](build/www/app) builds with
its own Dockerfile.

| Machine | Service |
| --- | --- |
| www | vAPI (Laravel) on port 80, exercises under `/vapi` |
| db | MySQL 8.0 on port 3306, seeded with upstream's `vapi.sql` |

## Run it

```bash
isoloom generate
isoloom run docker
```

Then open http://localhost/vapi for the exercise documentation and import the Postman collection
and environment from [`build/www/app/postman/`](build/www/app/postman). The same spec runs as
Docker on a local VM (`docker-vm`), on a cloud VM (`cloud-docker`) or on Kubernetes. Lab guide:
[upstream README](https://github.com/roottusk/vapi#usage) and its linked write-ups.

Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

GPL-3.0, as vAPI ([LICENSE](LICENSE)). This application is deliberately vulnerable: keep it
isolated.
