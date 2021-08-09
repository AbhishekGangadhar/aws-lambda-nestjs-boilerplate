#!/bin/bash
set -e


npm install

npm run build

npm prune --production

docker build -t test-lambda .

