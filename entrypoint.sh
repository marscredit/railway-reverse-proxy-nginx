#!/bin/sh

set -e

export TERM=ansi

_RED=$(tput setaf 1)
_RESET=$(tput sgr0)

write_red() {
  echo ${_RED}${1}${_RESET}
}

# Start Nginx
nginx -g "daemon off;"
