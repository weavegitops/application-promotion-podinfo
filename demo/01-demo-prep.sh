#!/bin/bash

echo "Preparing the demo"
echo "What git branch are you on now?"
BRANCH=$(git branch --show-current)
if [[ "$BRANCH" == "dev" ]]; then
    echo "You are on the dev branch"
else
    echo "Change to the dev branch"
    git checkout dev
fi

echo "Check current settings, run 04-demo-reset.sh if necessary."
grep ui-message ../cmd/podinfo/main.go
grep ui-color ../cmd/podinfo/main.go
grep VERSION ../pkg/version/version.go


