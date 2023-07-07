#!/bin/bash

#Requires you already have onepassword and the onepassword CLI tool installed
#Retrieves the cosign.key file for signing OCI artefact releases

op read --out-file cosign.key "op://WGE SA Demos/application-promotion-podinfo cosign key/cosign.key"
