#!/bin/bash

# Configuration
GOTIFY_URL="[URL TO YOUR GOTIFY SERVER]"
TOKEN="[INSERT API KEY HERE]"
PRIORITY=5

# Extract the IP address from the SSH_CONNECTION variable
IP=$(echo $SSH_CONNECTION | cut -d " " -f 1)

# Check if the session is opening or closing
if [ "$PAM_TYPE" = "open_session" ]; then
    TITLE="Login Alert"
    # Include the IP address in the message
    MESSAGE="User $PAM_USER logged into $HOSTNAME from IP $IP"
elif [ "$PAM_TYPE" = "close_session" ]; then
    TITLE="Logout Alert"
    # Include the IP address in the message
    MESSAGE="User $PAM_USER logged out from $HOSTNAME (IP was $IP)"
else
    # If PAM_TYPE is neither open_session nor close_session, exit the script.
    exit 0
fi

# Send notification
curl -X POST "$GOTIFY_URL?token=$TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"title\":\"$TITLE\",\"message\":\"$MESSAGE\",\"priority\":$PRIORITY}"
