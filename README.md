
# Podinfo Application Source Repository

This is the source code repository for the application. 

This is a monorepo, so all the environments are in the main branch.  
The environments are referenced by flux kustomizations from each cluster to the /environments/NAME directory.

There are 5 environments:
- 'dev' and 'dev-test', for the developers use,
- 'uat' or user acceptance testing, used by the testers,
- 'stg' or staging (managed like production) and
- 'prod' or production.

Commits should be done in a feature branch not in the main branch.

Each push by the developer of files in /pkg or /cmd will trigger a temporary build of the container and deploy to the 'dev' cluster.
This happens quickly, within 2-4 minutes.

After the developer is ready to release their changes, they modify the Helmchart in /charts/podinfo/Chart.yaml
- incrementing the version number of the chart
- incrementing the version of the container to include in the release.

A PR from the feature branch is then made against the main branch, this triggers the CI testing.
The CI tests then:
- Checks the version numbers were incremented
- builds the release container version
- Runs a Kind cluster and installs the new Helm chart with the new container and checks it installs correctly.

When the tests pass, the PR can be approved and merged to main.

This runs the chart-releaser process to release the Helm Chart in the github repository, which acts as a Helm repository.

The dev-test cluster detects the new chart in the Helm Repository and installs it automatically.

Then each cluster sends a webhook to the github repo when the Helm chart is 'ready'.
This creates a PR for each environment cluster to promote across each one.
i.e.

- dev-test pulls new Helm chart 
- PR created for 'uat' 
- Approve 
- Deploys chart to 'uat'
- PR created for 'stg' 
- Approve 
- Deploys chart to 'stg' 
- PR created for 'prod' 
- Approve 
- Deploys chart to 'prod' 


You can show the podinfo application from each of the clusters to visibly show the progressing versions of the app.

## Demo 2
- dev - app-promo-dev11           - http://172.16.20.211/podinfo
- dev-test - app-promo-dev-test12 - http://172.16.20.212/podinfo
- uat - app-promo-uat13           - http://172.16.20.213/podinfo
- stg - app-promo-stg14           - http://172.16.20.214/podinfo
- prod - app-promo-prod15         - http://172.16.20.215/podinfo


### Demo Features
1. Demostrate GitOps and policy checking across a multi-stage build pipeline.
2. Show a development environment with "instant" image deployment
3. Show a production environment that requires a pull request to deploy a new image
4. Show one design pattern for GitOps application promotion: monorepo, instant developer deployment, pull request gate


