## Overview

This example demonstrates how you can build a Docker image and push it to Artifactory. The image built in this example can be used as a base custom image for Pipelines, since it fulfills all requirements listed in [the docs](https://www.jfrog.com/confluence/display/JFROG/Choosing+your+Runtime+Image#ChoosingyourRuntimeImage-MinimumRequirementsforLinux).

## Pre-requisites

1. A working instance of [JFrog Pipelines](https://www.jfrog.com/confluence/display/JFROG/Installing+Pipelines)

## Running this sample

Please follow the steps below to execute this sample.

### Fork this repository
You will need to fork this repository to your account or organization. This is important since you need admin access to repositories that are used as Pipeline Sources or GitRepo resources, in order to add webhooks to these repositories and listen for change events.

### Add necessary integrations

For this sample, you need 2 integrations:
* [GitHub integration](https://www.jfrog.com/confluence/display/JFROG/GitHub+Integration): This integration will be used to add the Pipeline source, as well as the GitRepo resource defined in [pipelines.yml](https://github.com/jfrog/jfrog-pipelines-docker-sample/blob/master/pipelines.yml). Write down the GitHub integration name.

* [Artifactory integration](https://www.jfrog.com/confluence/display/JFROG/Artifactory+Integration): This integration is used to authenticate with Artifactory in order to push the Docker image to the docker-local repository in Artifactory. Write down the Artifactory integration name.

### Update pipelines.yml

The pipelines configuration is available in the `pipelines.yml` file. This file contains the following:

* `dbp_repo`, a GitRepo resource pointing to the repository containing the Dockerfile and other source code required to build the image
* `dbp_image`, an Image resource that will point to the image in Artifactory
* `pipeline_dbp`, the pipeline definition for building and pushing the Docker image.
  * `docker_build`, a DockerBuild step that builds the specified Docker image. This accepts `dbp_repo` as an inputResource in order to build the image based on provided Dockerfile
  * `docker_push`, a DockerPush step that pushes the specified Docker image to Artifactory. This step outputs the `dbp_image` resource, which can be used to trigger downstream dependent steps or pipelines if needed.

Update the pipelines configuration file to reflect your repository path, integration names, and image name. We have included comments in `pipelines.yml` to specify what needs to be updated.

### Add Pipeline Source

Follow instructions to [add a Pipeline Source](https://www.jfrog.com/confluence/display/JFROG/Managing+Pipeline+Sources#ManagingPipelineSources-AddingaPipelineSource(SingleBranch). When you do this, your `pipelines.yml` is parsed and resources, steps, and pipelines are added as configured. After your Pipeline Source is synced successfully, you can navigate to the My Pipelines list by clicking on Pipelines->My Pipelines in the left navbar to see the newly added pipeline.

### Execute the pipeline

You can trigger the pipeline by committing a change to your repository, or by manually triggering it through the UI.
