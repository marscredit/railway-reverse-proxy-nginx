#!/bin/sh

set -e

export TERM=ansi

_RED=$(tput setaf 1)
_RESET=$(tput sgr0)

write_red() {
  echo ${_RED}${1}${_RESET}
}

# Check if PROXY_HOST is valid
if [[ $PROXY_HOST != *.railway.internal ]]; then
    write_red "Not a valid host: $PROXY_HOST"
    exit 0
fi

# Start Nginx
nginx -g 'daemon off;'
