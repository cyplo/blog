---
title: Waiting for AWS Elastic Beanstalk environment to become ready
date: 2018-04-23
tags: [aws]
---

Elastic Beanstalk on AWS seems to be one of those services that are pretty cool but it's hard to get to know them.
One of the tasks you may encounter while working with it is that after making some change to its configuration you would like to wait for it to be finished before proceeding further. The change may be setting an environment variable but can also be deploying a new version of the application. I created a small bash script to help with that, can be useful when you try to run this process unattended, e.g. from CI.

```bash
#!/bin/bash
set -e
set -o pipefail

application_name=$1
environment_name=$2
timeout_seconds=$3

function getStatus() {
echo `aws elasticbeanstalk describe-environments \
    --application-name $application_name --environment-name $environment_name |\
    jq -r '.Environments | .[]?' | jq -r '.Status'`
}

sleep_time_seconds=5
max_iterations_count=$(($timeout_seconds/$sleep_time_seconds))
iterations=0

echo "Waiting for a maximum of $timeout_seconds seconds for $environment_name to become ready"
status=$(getStatus)
while [[ ( $status != "Ready" ) && ( $iterations -lt $max_iterations_count ) ]]; do
    status=$(getStatus)
    echo $status
    sleep $sleep_time_seconds
    ((iterations+=1))
done
```

Happy coding !
