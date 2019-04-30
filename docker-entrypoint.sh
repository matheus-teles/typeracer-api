#!/bin/sh
# Interpreter identifier

set -e
# Exit on fail

rm -f /myapp/tmp/pids/server.pid

bundle check || bundle install --jobs 20 --retry 5 --binstubs="$BUNDLE_BIN"
# Ensure all gems installed. Add binstubs to bin which has been added to PATH in Dockerfile.

yarn install --check-files
# Ensure all node modules installed.

exec "$@"
# Finally call command issued to the docker service