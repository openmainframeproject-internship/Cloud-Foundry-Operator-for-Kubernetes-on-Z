## Cf-operato 
This job builds [Cloud Foundry Operator](https://github.com/cloudfoundry-incubator/cf-operator) on s390x. 

### Prerequisites:
* Jenkins plugins: 
    * git
    * S3 publisher
    * artifact Manager on S3
* [Docker](https://www.suse.com/documentation/sles-12/singlehtml/book_sles_docker/book_sles_docker.html#cha.docker.installation)
### Jenkins job:
* Uses the Cf-operator [repository URL](https://github.com/cloudfoundry-incubator/cf-operator/) for cloning and  management 
of the source code from the ```master``` branch.
* Credentials need to be created and set in "Build Environment" > "Use secret text(s) or file(s)" to variables,
later used in ``` docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD" ``` to log into Docker Hub and push the image.
* Execute the shell script `build-cf-operator`
* Publish artifact to S3 bucket. 

