## Fissile
This job builds [fissile](https://github.com/cloudfoundry-incubator/fissile).

### Prerequisites:
* Jenkins plugins: 
    * git
    * S3 publisher
    * artifact Manager on S3
* tar

### Jenkins job:
* Cloning and source code management comes from the [fissile repository](https://github.com/cloudfoundry-incubator/fissile.git), branch ```develop```
* Execute ```build-fissile``` shell script
* Publish artifact to S3 bucket.
