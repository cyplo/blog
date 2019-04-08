.. title: Configure AWS Elastic Beanstalk Docker environment variables
.. slug: configure-docker-env-vars-on-beanstalk
.. date: 2018-04-23 12:00:00 UTC
.. tags: aws, amazon, eb, elastic beanstalk, docker
.. category: 
.. link: 
.. description: How to configure environment variables for docker on AWS Elastic Beanstalk
.. type: text

AWS Beanstalk is a good 'intermediate' level hosting for Docker containers. It gives you load balancing and scalability pretty much out of the box in exchange for being a bit more opaque to configure. The Docker bits are a bit more hidden away there. 
In a typical production setup you would want to have Docker images not containing anything environment related, e.g. to be able to run them both in production and locally. An easy way to achieve that with Docker is via environment variables. On the local environment it's `docker run --env NAME=VALUE` - what would be a Beanstalk equivalent though ?

It turns out that Beanstalk has a magical configuration directory structure that you can pass to an environment. 
It goes like this:

```
configuration.zip
   Dockerrun.aws.json 
   .ebextensions/
       environmentvariables.config
```

Where `Dockerrun.aws.json` is your regular Docker definition file for Beanstalk, can look like this:
```
{
    "AWSEBDockerrunVersion": "1",
    "Image": {
        "Name": "image:latest",
        "Update": "true"
    },
    "Ports": [
        {
        "ContainerPort": "1234"
        }
    ]
}
```

While `.ebextensions/environmentvariables.config` is where, well, you set the environment variables that will be defined in the container. Example:

```
option_settings:
  - option_name: ENV_VAR1
    value: "some value"
  - option_name: ENV_VAR2
    value: "some other value"
```

But wait, there's more ! Get the zip file and upload it to some S3 bucket, I'm going to assume that the file is at `BUCKET_NAME/CONFIG_PATH` in the example below.
Then you need to tell Beanstalk where the file is located. This can be achieved by creating a new application version:

```
aws elasticbeanstalk create-application-version --application-name APPLICATION_NAME --version-label VERSION --source-bundle S3Bucket=BUCKET_NAME,S3Key=CONFIG_PATH
aws elasticbeanstalk update-environment --environment-name ENVIRONMENT_NAME --version-label VERSION
```
