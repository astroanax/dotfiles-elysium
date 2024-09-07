#!/bin/sh

USER="astroanax"
TOKEN=`cat ~/.config/github-token`

notifications=$(echo "user = \"$USER:$TOKEN\"" | curl -sf -K- https://api.github.com/notifications | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo "$notifications GH |"
else
    echo ""
fi
