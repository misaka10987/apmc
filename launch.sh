#!/bin/bash
set -e
warp-cli disconnect
sleep 2
java -jar "./server.jar"
sync() {
    branch="autosave-$(date -u +%Y%m%d-%H%M%S)"
    git checkout -b $branch
    git add *
    git commit -m "Autosaved."
    git push origin $branch
    rm ./logs/*.gz
}
