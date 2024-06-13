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

HOST_PORT=${RAILWAY_TCP_PROXY_DOMAIN}:${RAILWAY_TCP_PROXY_PORT}

# Generate Caddyfile content
cat <<EOL > /etc/caddy/Caddyfile
{
	admin off
	persist_config off
	auto_https off
	log {
		format json
	}
	servers {
		trusted_proxies static private_ranges
	}
}

:443 {
	log {
		format json
	}

	reverse_proxy http://$HOST_PORT {
		header_up Host {upstream_hostport}
		header_down Upgrade-Insecure-Requests "1"
		header_down Content-Security-Policy "upgrade-insecure-requests"
	}
}
EOL

# Start Caddy
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
