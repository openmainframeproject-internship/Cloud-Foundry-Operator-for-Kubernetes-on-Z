## S390x fissile stemcell
This job builds openSUSE Fissile Stemcell.

### Prerequisites:
* Jenkins plugins: 
    * git 
* [Docker](https://www.suse.com/documentation/sles-12/singlehtml/book_sles_docker/book_sles_docker.html#cha.docker.installation)


### Jenkins job:
* Utilises the [repository URL](https://github.com/SUSE/fissile-stemcell-openSUSE.git) for cloning and source code management, but from the ``'42.3-s390x'`` branch (Branch Specifier: "refs/heads/42.3-s390x").
* One more time the credentials are used and applied to variables in "Build Environment" > "Use secret text(s) or file(s)", later applied to login and push the built image to Docker Hub.
* Shell script ```build-stemcell``` is executed

