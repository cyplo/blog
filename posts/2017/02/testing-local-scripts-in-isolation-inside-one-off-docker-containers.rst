.. title: Testing local scripts in isolation inside one-off Docker containers
.. slug: testing-local-scripts-in-isolation-inside-one-off-docker-containers
.. date: 2017-02-17 22:08:46 UTC
.. tags: 
.. category: 
.. link: 
.. description: 
.. type: text

I am quite bad at remembering how to launch docker to have everything set up correctly. Hence the following - a script that launches any commandline specified in its arguments inside a new docker container. Current directory is mounted inside the container automatically, so the thing you are executing can have its local dependencies satisfied.

.. code-block:: bash

    #!/bin/bash
    USERNAME=`whoami`
    MOUNT_PATH="/mnt"
    CURRENT_DIRECTORY=`pwd -P` # untangle symbolic links if needed - SELinux needs the real path
    IMAGE="debian:jessie"

    if [[ -z $1 ]]; then
        echo "usage: `basename $0` command_to_run_inside_a_container"
        exit 1
    fi

    RESOLVED_ARGUMENTS="$@"
    docker run -i -t -v "$CURRENT_DIRECTORY":"$MOUNT_PATH":Z $IMAGE bash -c "useradd -M -d '$MOUNT_PATH' $USERNAME && cd '$MOUNT_PATH' && bash -c '$RESOLVED_ARGUMENTS'"

    # restore SELinux context for the current directory
    restorecon_path=`which restorecon`
    if [[ -x "$restorecon_path" ]]; then 
        restorecon -R "$CURRENT_DIRECTORY"
    fi

I use vanilla Debian Jessie as a run platform there, mostly because this is what most of my servers run.
The script covers setting up SELinux and mounting the directory from which it is run as ``/mnt`` inside the container while also having the default non-root user added.

Run Jessie, run !