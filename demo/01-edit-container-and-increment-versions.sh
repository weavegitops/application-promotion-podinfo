#!/bin/bash

echo "Here are links to Demo2 cluster environments for the podinfo app:"
echo "dev - http://172.16.20.211/podinfo"
echo "dev-test - http://172.16.20.212/podinfo"
echo "uat - http://172.16.20.213/podinfo"
echo "stg - http://172.16.20.214/podinfo"
echo "prod - http://172.16.20.215/podinfo"
echo "Open browser windows to each of these to show the progression during the demo."
echo
echo "Press a Key"
echo
read -n1 -s
echo "To start we are going to create a git repo feature branch to develop our changes to the conatiner code."
git checkout main
git pull
git checkout -b demo-podinfo-updates
echo
echo "Now we have a feature branch, we can start making changes to the container code"
echo
echo "We are going edit the container code to set the color of the background of the podinfo app"
echo "The default background color is set here:"
echo
grep ui-color ../cmd/podinfo/main.go
echo
echo "We are going to change it to a different background color and then show how the promotion works across environments."
read -n1 -s
UI_COLOR=$(grep ui-color ../cmd/podinfo/main.go | sed -e 's/^.*ui-color", "//' -e 's/", "UI color")$//')
if [ "$UI_COLOR" == "#34577c" ]; then
	cp main.go.edited ../cmd/podinfo/main.go
else
	cp main.go.default ../cmd/podinfo/main.go
fi
echo "Now the color is changed and it is set like this:"
grep ui-color ../cmd/podinfo/main.go
echo
echo "We add, commit and push the changes to the repository feature branch"
echo
git add ../cmd/podinfo/main.go
git commit -m 'change the background colour'
git push --set-upstream origin demo-podinfo-updates
echo
echo "Pause here to show the podinfo app on the dev cluster"
echo "This will show the colour change in the new container version, to give fast feedback to the developer."
echo
echo "Press a key to continue"
read -n1 -s
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
read -n1 -s
echo "We also need to set the version of the container in the helm chart values"
yq eval '.image.tag=env(NEXTVERSION)' -i ../charts/podinfo/values.yaml
echo "Container tag set in the helm chart to ${NEXTVERSION}"
echo
echo "Then we increment the version of the helm chart to release the new Helm chart with the new podinfo container"
HELM_VERSION=$(yq .version ../charts/podinfo/Chart.yaml)
echo "Current Helm chart version: $HELM_VERSION"
export HELM_NEXT=$(echo ${HELM_VERSION} | awk -F. -v OFS=. '{$NF += 1 ; print}')
yq eval '.version=env(HELM_NEXT)' -i ../charts/podinfo/Chart.yaml
echo "Helm chart version set to: ${HELM_NEXT}"
echo
echo "Next we create the git repo branch and push to the repo"
read -n1 -s
echo "git add and commit changes"
git add ../
git commit -m "Update container to version ${NEXTVERSION} and Helm chart to version ${HELM_NEXT}"
echo "git push changes to the repository"
git push
echo
echo "Now we need to create a PR for the feature request, once a PR is created the tests will run in CI"
echo "Go and create a PR here: https://github.com/weavegitops/application-promotion-podinfo/pulls"
echo "Then show the tests running here: https://github.com/weavegitops/application-promotion-podinfo/actions"
echo
echo "Press a key"
read -n1 -s
echo "Once all the tests have passed, it is time to merge the PR to release the Helm chart"
echo "Merge the PR here: https://github.com/weavegitops/application-promotion-podinfo/pulls"
echo
echo "Press a Key"
echo
read -n1 -s
echo "============================================================================================================="
echo "Once the PR is merged, this will run the Helm chart release process and make the new chart available for deployment."
echo "The dev-test environment will receive this change automatically once the release is completed"
echo "Now show the podinfo app on the dev-test cluster to see it deployed."
echo
echo "Press a Key"
echo
read -n1 -s
echo "To promote this to the UAT environment:"
echo "Approve the PR to deploy to UAT in the github repo here:"
echo "https://github.com/weavegitops/application-promotion-podinfo/pulls"
echo 
echo "Press a Key"
echo
read -n1 -s
echo "To promote this to the stg environment:"
echo "Approve the PR to deploy to stg in the github repo here:"
echo "https://github.com/weavegitops/application-promotion-podinfo/pulls"
echo 
echo "Press a Key"
echo
read -n1 -s
echo "To promote this to the prod environment:"
echo "Approve the PR to deploy to prod in the github repo here:"
echo "https://github.com/weavegitops/application-promotion-podinfo/pulls"
echo 
echo "The demo is now completed"
