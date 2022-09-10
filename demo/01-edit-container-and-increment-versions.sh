#!/bin/bash

echo "We are now going to edit the ui-message onscreen here"
echo
grep ui-message ../cmd/podinfo/main.go
echo
echo "and the ui-color here"
echo
grep ui-color ../cmd/podinfo/main.go
echo
read -n1 -s
UI_COLOR=$(grep ui-color ../cmd/podinfo/main.go | sed -e 's/^.*ui-color", "//' -e 's/", "UI color")$//')
if [ "$UI_COLOR" == "#34577c" ]; then
	cp main.go.edited ../cmd/podinfo/main.go
else
	cp main.go.default ../cmd/podinfo/main.go
fi
echo "Now they look like this:"
grep ui-message ../cmd/podinfo/main.go
grep ui-color ../cmd/podinfo/main.go
echo
echo "We are also going to increment the version of the application, it is currently"
VERSION=$(grep VERSION ../pkg/version/version.go | sed -e 's/var VERSION = "//' -e 's/"//')
echo "$VERSION"
read -n1 -s
echo "Now we update it to:"
export NEXTVERSION=$(echo ${VERSION} | awk -F. -v OFS=. '{$NF += 1 ; print}')
echo $NEXTVERSION
grep -v VERSION ../pkg/version/version.go > version.go.edited
echo "var VERSION = \"${NEXTVERSION}\"" >> version.go.edited
cp version.go.edited ../pkg/version/version.go
rm -f version.go.edited
echo
echo "Now it looks like this:"
cat ../pkg/version/version.go
echo
echo "We also need to set the version of the container in the helm chart values"
yq eval '.podinfo.image.tag=env(NEXTVERSION)' -i ../charts/podinfo/values.yaml
echo "Container tag set in the helm chart to ${NEXTVERSION}"
echo
echo "Then we increment the version of the helm chart to relase the new Helm chart with the new docker container"
HELM_VERSION=$(yq .version ../charts/podinfo/Chart.yaml)
echo "Current Helm chart version: $HELM_VERSION"
export HELM_NEXT=$(echo ${HELM_VERSION} | awk -F. -v OFS=. '{$NF += 1 ; print}')
yq eval '.version=env(HELM_NEXT)' -i ../charts/podinfo/Chart.yaml
echo "Helm chart version set to: ${HELM_NEXT}"
echo
echo "Next we create the git repo branch and push to the repo"
read -n1 -s
echo "git add and commit changes"
git checkout -b demo-podinfo-updates
git add ../
git commit -m "Update container to version ${NEXTVERSION} and Helm chart to version ${HELM_NEXT}"
echo "git push changes to the repository"
git push
echo "The dev-test environment will receive this change automatically"
echo "Create a PR to main from the branch demo-podinfo-updates in the github repo here:"
echo "https://github.com/weavegitops/application-promotion-podinfo"
echo 
echo "The PR created will then run the CI testing."
echo "When this passes the tests, merge the change into main"
echo "This will trigger the Helm release process and promote across the environments via PRs you have to approve."
echo
echo "To display the progress open 5 browser windows for each of the environments:"
echo "Demo2 links:"
echo "dev - http://172.16.20.211/podinfo"
echo "dev-test - http://172.16.20.212/podinfo"
echo "uat - http://172.16.20.213/podinfo"
echo "stg - http://172.16.20.214/podinfo"
echo "prod - http://172.16.20.215/podinfo"

