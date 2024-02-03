#!/bin/bash

# Only proceed if this is the opening of a session
if [ "$PAM_TYPE" != "open_session" ]; then
    exit 0
fi

# Configuration
GOTIFY_URL="[INSERT URL TO GOTIFY SERVER]"
TOKEN=[INSERT API TOKEN/KEY]
TITLE="Sudo Alert"
MESSAGE="User $PAM_USER executed sudo command on $HOSTNAME"
PRIORITY=5

# Send notification
curl -X POST "$GOTIFY_URL?token=$TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"title\":\"$TITLE\",\"message\":\"$MESSAGE\",\"priority\":$PRIORITY}"
