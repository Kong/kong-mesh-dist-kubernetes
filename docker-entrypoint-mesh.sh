#!/bin/sh
set -e

export KONG_NGINX_DAEMON=off

if [[ "$1" == "kong" ]]; then
  PREFIX=${KONG_PREFIX:=/usr/local/kong}
  mkdir -p $PREFIX

  if [[ "$2" == "docker-start" ]]; then
    kong prepare -p $PREFIX
    chown -R kong /usr/local/kong #todo
    chmod 777 /proc/self/fd/{1,2} #todo
    exec su kong -c "/usr/local/openresty/nginx/sbin/nginx -p $PREFIX -c nginx.conf"
  fi
fi

exec "$@"