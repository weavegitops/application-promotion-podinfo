## Application Pipeline Demonstration

***READ THE WHOLE DOCUMENT AND PRACTICE***

### Overview
This demo is a simple application pipeline demonstration. The pipeline consists of a 'dev' environment and a 'production' environment. Developers would be working on the application source code, and will commit their changes. When they commit their changes, the application is built from source, the deployment manifest in updated in the 'dev' environment, the 'dev' environment is immediately commited to allow the developers to test their application. As a part of this GitOps automation, the deployment has policy checks to ensure that even in the development environment the application meets the required policies that will be used in the production deployment.

The action also creates a pull request to deploy into the 'production' environment with the same policy checks. In order for the application to be deployed into 'production', the pull request must be merged.

### Demonstration Setup
1. Port forward the 'podinfo' service from both the 'dev' and 'production' enviroments so the results of the commit, build, merge GitOps process can be observed.
2. Have the source code repository on Github open to view the actions and pull request.
3. [Optional] Have the diagram slide for this demonstration.

### Demonstration Goals
- Show one GitOps repository design pattern (branches) for application development and promotion
- Show policy checking at commit time (check policy with auditing before deployment)
- Show utilizing pull requests as a "gate" for deployment into 'production' (reduce risk from automation)
- Show a very short development CI time with instant deployment/policy checking for developers (rapid turnaround)
- Show different deployment methods for 'dev' and 'production' with GitOps. (flexibility)

### Demonstration Steps
(These are very simple. Please try it and practice to get your own flow for the demo)
1. Switch to the 'dev' branch
2. Edit the 'cmd/podinfo/main.go' line 43, and change the color. Valid values are: 'red' 'blue' 'green' etc.
	1. ` fs.String("ui-color", "#34577c", "UI color") `
	2. Change the middle value ... ensure the quotes and commas are correct or the build will fail)
3. Edit the 'pkg/version/version.go' line 3 and increment the version number.
4. Commit and push (if required) the changes you made
5. Switch to the 'Actions' for the repository, watch the action execute (2 - 3 minutes)
6. Once everything completes, show the 'dev' port-forward of the 'podinfo' to show the color changed.
7. Switch to the 'Pull Requests' for the repository. Merge the pull request.
8. Show the 'production' port-forward of the 'podinfo' to show the color changed.
9. As the wrap up, show how GitOps audited every change, and what changed.

### Demo scripts
There are some demo scripts to help you run the CLI parts of the demo.
Use these once you are familiar with the process and have done it without the scripts first.
Run them in order:
1. 01-demo-prep.sh
2. 02-make-dev-change.sh
3. 03-promote-to-prod.sh
4. 04-demo-reset.sh 
