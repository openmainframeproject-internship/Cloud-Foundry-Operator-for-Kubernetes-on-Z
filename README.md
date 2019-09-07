# Cloud Foundry Operator for Kubernetes on Z


## Table of Contents
* [Introduction](#Introduction)
* [Project Plan](#Project-Plan)
* [Launch](#Launch)
* [Implementation](#Implementation)
## Introduction
This project builds the Cloud Foundry Operator on Z using [Fissile](https://github.com/cloudfoundry-incubator/fissile).
## Project Plan
### Outcome: Build Cloud Foundry Operator on Z

The following is a plan that I’ve developed together with my mentor Vlad:
* [**DONE**] Procure a VM on Z and create a development environment containing the following:
  * go
  * docker
  * kubernetes
  * helm (and tiller)

* [**DONE**] Compile the cf-operator binary on the Z VM
* [**DONE**] Complete one feature of the cf-operator, to familiarize myself with the codebase (*Estimation 10th of July*)
* [**DONE**] Deploy the Cloud Foundry Operator on Kubernetes with and without Helm (*Estimation 20th of July*)
* [**DONE**] Build a stemcell docker image and a BOSH release on Z (*Estimation 3rd of August*)
* [**DONE**] Pipelines for automatically building the following on Z (*Estimation 1st of September*)
  * Cloud Foundry Operator
  * Stemcell image(s)
  * BOSH releases

## Launch
* Jenkins:

## Implementation
The main objective was to implement the Cloud Foundry Operator on Z. In order to achieve this we had to follow a few steps:
1. Install Jenkins: We use it to build the cf-operator, fissile, stemcells, and to turn BOSH releases into images.
2. Create a cf-operator s390x Dockerfile: 
- the [cf-operator Dockerfile](https://github.com/cfcontainerizationbot/cf-operator-base/blob/master/Dockerfile) installs some packages (`ruby`, `bosh-template`, `inotify-tools`, etc.) from `opensuse/leap:15.1`, but since this is not available on s390x, we had to adapt and use `opensuse/tumbleweed`
- the `Dockerfile` had to be changed so it uses s390x versions of packages (`golang`, `dumb-init``)
- we had to use the s390x versions of build images (`alpine`, `golang`, etc.)

3. Build the fissile stemcell

```
docker build -t \
    cfcontainerization/s390x-fissile-stemcell \
    --build-arg base_image=opensuse/tumbleweed \
    --build-arg stemcell_version=0.0.0 .
```

The stemcell requires some parameters:
- `base_image`, which we set to `opensuse/tumbleweed`, as explained earlier
- `stemcell_version` which is currently `0.0.0` and should be replaced with a build number from Jenkins

At this point the build would throw an error because installing `ruby`/`configgin` with `rvm` doesn't work on s390x. The solution is to install `ruby` directly from openSUSE (`zypper -n in ruby`) and remove `configgin` (CF Quarks no longer uses it).

4. Build fissile: 
- Run the following commands:
    ```bash 
    export GOPATH=`mktemp -d`                               # export GOPATH to a new temporary directory
    mkdir -p $GOPATH/src/code.cloudfoundry.org/             # create new directories within the temporary one
    ln -s `pwd` $GOPATH/src/code.cloudfoundry.org/fissile   # link the current working directory with the temporary directory
    cp -r vendor/* $GOPATH/src                              # copy all files from “vendor” to the temporary file
    rm -rf vendor                                           # remove the permanent vendor directory 
    OSES=linux                                              # set OSES parameter to “linux”
    make build                                              # build the fissile
    ```
5. Updating BOSH-releases: Fissile needs s390x packages to update the BOSH releases. For that we have made a shell script named `run-quarks-patches`:
    1. Downloads the bosh release using `wget`.
    2. Unzip the .tgz using `gunzip`
    3. Iterate through the .tar and update the packages.
    4. Use `gzip` to zip the .tar.

    The script takes 4 parameters: name of the release, version, URL,package directory and the output directory with the updated tar.gz files. 
    
    Example: 
    ```   
    run-quarks-patches \ 
        nats \
        27 \ 
        "https://bosh.io/d/github.com/cloudfoundry/nats-release?v=27" \  
        ./fissile-workspace/patches \
        ./fissile-workspace/output \
    ```


