# How to build the target clusters on demo environments

## Introduction

We will need 5 clusters to deploy to in each demo environment as targets.

## Building Clusters

Use the liquidMetal single node edge case template called:
`lm-edge`

Cluster List:
- app-promo-dev11 - CP IP: 172.16.X.11 Loadbalancer IP: 172.16.X.211
- app-promo-dev-test12 - CP IP: 172.16.X.12 Loadbalancer IP: 172.16.X.212
- app-promo-uat13- CP IP: 172.16.X.13 Loadbalancer IP: 172.16.X.213
- app-promo-stg14- CP IP: 172.16.X.14 Loadbalancer IP: 172.16.X.214
- app-promo-prod15- CP IP: 172.16.X.15 Loadbalancer IP: 172.16.X.215

Where X is set by the demo environment: demo2: X=20, demo3: X=30.

## Deploying the application-promotion-podinfo app

You will need to deploy the app by adding a Kustomization, secret and GitRepository source for the application-promotion-podinfo repo.


