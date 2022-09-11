
# Podinfo Application Source Repository

This is the source code repository for the application. This is a monorepo, so all the environments are in the main branch.  The environments are referenced by flux kustomizations from each cluster to the /environments/NAME directory.

There are 5 environments, 'dev' and 'dev-test', for the developers use, uat or user acceptance testing, used by the testers, staging (managed like production) and production.

Commits should be done in a feature branch.

Each push by the developer of files in /pkg or /cmd will trigger a build of the container.

The dev cluster has Image Automation which watches the ghcr.io container registry for the latest tag.  If there is a new tag, it pushes changes directly to main to update the tag for the Podinfo Deployment.yaml manifest, which flux syncs and it downloades the new cluster image.  This happens quickly, within 2-4 minutes.

After the developer is ready to release his changes, he creates a new Helmchart and increments the version number and increments the version of the container to include in the release.

A PR from the feature branch is then made against the main branch, this triggers the CI testing.

This checks if the versions have been incremented and builds the docker container to the new tagged version, tests the helm chart install succeeds.

When the tests pass, the PR can be approved and merged.

Once merges the Helm release process is triggered, which releases the Helm Chart.

The dev-test cluster will automatically detects the new chart and upgrade it automatically.

The dev-test cluster is running a github provider for the notification controller that sends a githubdispatch event to github once the helm chart upgrade is completed.

The github action is triggered that creates a PR to the Helm Chart version on the UAT cluster.

Once the PR is approved and merged, the UAT cluster receives the new helm chart and container, this creates another PR to the stg environment.

Once the PR is approved the Helm Chart deploys to stg and creates the last PR to prod.

Approve and merge and the production deployment is completed.

You can show the podinfo application from each of the clusters to visibly show the progressing versions of the app.

## Demo 2
- dev - app-promo-dev11 - http://172.16.20.211/podinfo
- dev-test - app-promo-dev-test12 http://172.16.20.212/podinfo
- uat - app-promo-uat13 - http://172.16.20.213/podinfo
- stg - app-promo-stg14 - http://172.16.20.214/podinfo
- prod - app-promo-prod15 - http://172.16.20.215/podinfo


### Demo Features
1. Demostrate GitOps and policy checking across a multi-stage build pipeline.
2. Show a development environment with "instant" image deployment
3. Show a production environment that requires a pull request to deploy a new image
4. Show one design pattern for GitOps application promotion: monorepo, instant developer deployment, pull request gate


