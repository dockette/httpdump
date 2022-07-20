#!/bin/bash
set -Eeo pipefail

mkdir -p /srv/storage/framework/{sessions,views,cache}
chmod -R 755 /srv/storage/framework
chown -R www-data:www-data /srv/storage/framework

/usr/sbin/php-fpm7.4 -F -R -y /etc/php/7.4/php-fpm.conf &
caddy run -config /etc/Caddyfile &
wait -n
