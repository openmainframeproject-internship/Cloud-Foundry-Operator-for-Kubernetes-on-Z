## Patch Releases
This job uses [fissile](https://github.com/cloudfoundry-incubator/fissile) to turn BOSH releases into images.

### Prerequisites:
* Jenkins plugins: 
    * git
* tar

### Jenkins job:
* Uses the Cf-operator [repository URL](https://github.com/cloudfoundry-incubator/cf-operator/) for cloning and  management 
of the source code from the ```master``` branch, where the ```run-quarks-patches.sh``` script is stored.
* Credentials need to be created and set in "Build Environment" > "Use secret text(s) or file(s)" to variables,
later used in ``` docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD" ``` to log into Docker Hub and push the image.
* Execute ```patch-releases``` shell script
