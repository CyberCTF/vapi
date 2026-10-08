# Upstream

| | |
| --- | --- |
| Project | vAPI |
| Repository | https://github.com/roottusk/vapi |
| Version | 1.3 |
| Commit | 6292bb27a42d15b3044155f8dd90b919f00a9e38 |
| Licence | GPL-3.0 |

`build/www/app/` is that release, unchanged, without its Git history. `build/www/Dockerfile` is
upstream's Dockerfile with two changes: the `composer` image it copies from is pinned to `2.8`
instead of `latest`, and the environment upstream's docker-compose.yml sets for the `www` service
is baked in as `ENV`. PHP dependencies are vendored by upstream (`app/vapi/vendor/`).
`build/db/Dockerfile` is upstream's `db` service (`mysql:8.0` with its environment and command);
`build/db/initdb/vapi.sql` is an unchanged copy of `build/www/app/database/vapi.sql`, because each
build folder is its own Docker context. Upstream's optional phpMyAdmin service is left out. To
update, replace `build/www/app/` with a newer release, copy its `database/vapi.sql` to
`build/db/initdb/`, then change this table.
