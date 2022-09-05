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
echo "Here is the main.go file for the podinfo application"
cat ../cmd/podinfo/main.go
read -n1 -s
echo "We are now going to edit the ui-message onscreen here"
grep ui-message ../cmd/podinfo/main.go
echo "and the ui-color here"
grep ui-color ../cmd/podinfo/main.go
read -n1 -s
cp main.go.edited ../cmd/podinfo/main.go
echo "Now they look like this"
grep ui-message ../cmd/podinfo/main.go
grep ui-color ../cmd/podinfo/main.go
echo "We are also going to update the version of the application, it is currently"
grep VERSION ../pkg/version/version.go
echo "Now we update it"
read -n1 -s
cp version.go.edited ../pkg/version/version.go
echo "Now it looks like this"
grep VERSION ../pkg/version/version.go
echo "git add and commit changes"
read -n1 -s
git add ../
git commit -m 'Update ui-message, ui-color and version to 6.1.4'
echo "git push changes to the repository"
git push
echo "The dev environment will receive this change automatically"
echo "To view the dev cluster you will need to port forward the podinfo service"
echo "For example:" 
echo "kubectl --context=lm20-admin@lm20 port-forward svc/podinfo -n application-podinfo 8080:9898"
echo "Then connect your browser to http://localhost:8080"

