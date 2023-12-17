#!/bin/bash
set -e

sync() {
    echo "Connecting to Cloudflare WARP:"
    warp-cli connect
    sleep 2
    local branch="auto-$(date -u +%Y%m%d.%H%M%S)"
    git checkout -b $branch
    git add *
    git commit -m "Autosaved."
    git push origin $branch
    warp-cli disconnect
}

main() {
    warp-cli disconnect
    sleep 2
    java -jar "./server.jar"
    sleep 2
    echo "Server closed. Automatically backup..."
    echo "Done."
    sync
}

main