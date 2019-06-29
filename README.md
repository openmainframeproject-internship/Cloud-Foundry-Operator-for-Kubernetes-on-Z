# Cloud Foundry Operator for Kubernetes on Z: Project Plan
### Outcome: Build Cloud Foundry Operator on Z

The following is a plan that I’ve developed together with my mentor Vlad:
* [**DONE**] Procure a VM on Z and create a development environment containing the following:
  * go
  * docker
  * kubernetes
  * helm (and tiller)


* [**DONE**] Compile the cf-operator binary on the Z VM
* [**IN PROGRESS**] Complete one feature of the cf-operator, to familiarize myself with the codebase (*Estimation 10th of July*)
* Deploy the Cloud Foundry Operator on Kubernetes with and without Helm (*Estimation 20th of July*)
* Build a stemcell docker image and a BOSH release on Z (*Estimation 3rd of August*)
* Pipelines for automatically building the following on Z (*Estimation 1st of September*):
  * Cloud Foundry Operator
  * Stemcell image(s)
  * BOSH releases
