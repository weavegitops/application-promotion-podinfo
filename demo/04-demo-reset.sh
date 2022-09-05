#!/bin/bash

echo "Resetting the demo"
echo "What git branch are you on now?"
BRANCH=$(git branch --show-current)
if [[ "$BRANCH" == "dev" ]]; then
    echo "You are on the dev branch"
else
    echo "Change to the dev branch"
    git checkout dev
fi
echo "Reset the main.go file to the default color and message"
cp main.go.default ../cmd/podinfo/main.go
echo "Reset the version.go file to the default version number: 6.1.3"
cp version.go.default ../pkg/version/version.go
echo "git add and commit changes"
git add ../
git commit -m 'Revert to default demo state'
echo "git push changes to the repository"
git push
echo "Demo is reverted locally, make sure you also approve the changes to the main branch in the repo here:"
echo "https://github.com/weavegitops/application-podinfo/pulls"
