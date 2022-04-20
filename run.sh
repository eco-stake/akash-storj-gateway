#!/bin/sh

set -e

[ -z "$ACCESS_GRANT" ] && echo "ACCESS_GRANT empty" && exit

./gateway setup --access ${ACCESS_GRANT} --non-interactive

exec "$@"