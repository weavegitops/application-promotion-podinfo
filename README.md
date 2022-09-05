
# Podinfo Application Source Repository

This is the source code repository for the application. The repo contains two branches, 'dev' and 'main'. Commits to 'dev' trigger a build and a pull request to the 'main' branch. The updates and pull request is handled in GitHub actions, and utilizes this tool for generating PRs:  https://github.com/fjogeleit/yaml-update-action

The GitOps targets for these two branches would be two clusters (or namespaces).

The slides for use with this demo are here: https://docs.google.com/presentation/d/1cPmD6f_M-d7FWtOzLBK3ivjZrwvqOS8boVO8nRv4S_M/edit?usp=sharing

The demo script is here: https://github.com/weavegitops/application-podinfo/blob/main/SCRIPT.md

### Demo Features
1. Demostrate GitOps and policy checking across a simple two-stage build pipeline.
2. Show a development environment with "instant" image deployment
3. Show a production environment that requires a pull request to deploy a new image
4. Show commit time policy checking for both development and production
5. Show one design pattern for GitOps application promotion: branch pattern, instant developer deployment, pull request gate


