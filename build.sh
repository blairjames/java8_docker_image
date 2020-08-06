#!/usr/bin/env bash
# -------------------------------------------------------------------------+ 
# Build, Test, Push, Deploy Simple Java8 Development environment container | 
# -------------------------------------------------------------------------+

# Env Vars for SSH.
source $HOME/.ssh/agent/env || . $HOME/.ssh/agent/env

# Log file
log="/home/docker/java8_docker_image/log.build"

# Generate timestamp
timestamp () {
    date +"%Y%m%d_%H%M%S"
}

# Log and Print
logger () {
    printf "$(timestamp) - $1\n" | tee -a $log
}

# Exception Catcher
except () {
    logger $1
    return 1
}

# Assign timestamp to static point in time.
timestp=$(timestamp)
logger "Starting Build.\n"

# Build the image using timestamp as tag.
if sudo /usr/bin/docker build /home/docker/java8_docker_image -t blairy/java8:$timestp | tee -a $log; then
    logger "Build completed successfully.\n\n"
else
    logger "Build FAILED!! Aborting.\n\n"
    exit 1
fi

# Run Tests
if /home/docker/java8_docker_image/test_script.sh blairy/java8:$timestp | tee -a $log; then
    logger "Tests completed successfully.\n\n"
else
    logger "******  WARNING!!  --  Tests FAILED!!  Aborting. ******\n\n"
    exit 1
fi

# Push to github - Triggers builds in github and Dockerhub.
git () {
    git="sudo /usr/bin/git -C /home/docker/java8_docker_image"
    $git pull git@github.com:blairjames/java8_docker_image.git \
        | tee -a $log || except "git pull failed!"
    $git add --all | tee -a $log || except "git add failed!"
    $git commit -a -m 'Automatic build '$timestp | tee -a $log || except "git commit failed!"
    $git push | tee -a $log || except "git push failed!"
}

# Run the git transactions
if git; then
    logger "git completed successfully." 
else
    logger "git failed!!" 
    exit 1
fi

# Push the new tag to Dockerhub.
if sudo docker push blairy/java8:$timestp | tee -a $log; then 
    logger "Docker push completed successfully.\n\n"
else
    logger "Docker push FAILED!!\n\n"
    exit 1 
fi

# All completed successfully
logger "All completed successfully"
exit 0
