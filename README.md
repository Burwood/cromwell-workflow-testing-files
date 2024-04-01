# Cromwell Workflow Execution Tests

This repository contains configuration files and a script for testing workflow execution using Cromwell with both the Google Pipelines API (PAPI) and Google Cloud Batch backends.

## Overview

The purpose of these tests is to evaluate and compare the performance of Cromwell when running workflows on Google Cloud's Pipelines API versus Google Cloud Batch. This repository includes all necessary configurations and scripts to replicate these tests. Please note that these tests were conducted inside a Compute Engine Instance VM.

## Repository Contents
- batch.conf and papi.conf: configuration files for both PAPI (`papi.conf`) and Batch (`batch.conf`) backends.
- Includes the Bash script (`submit_workflows.sh`) for submitting batch workflows to Cromwell.

## Command used to start cromwell in server mode
- java -server -Xms512m -Xmx128g -XX:NewSize=3g -XX:MaxNewSize=3g -XX:SurvivorRatio=8 -XX:+UseG1GC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=60 -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark -verbose:gc -Dwebservice.port=8000 -Dconfig.file=[PATH TO CONF FILE] -jar [PATH TO JAR FILE] server

## Jar files

You will need to create two jar files:
1. The first will be created from the develop branch: https://github.com/broadinstitute/cromwell
2. The second from the following commit: https://github.com/broadinstitute/cromwell/tree/f6cdc3ad9187aa4eb49924350a67880a9480f398

These first will be used to test PAPI, the second to test Batch

## Running Tests

### With Pipelines API (PAPI)
1. Open a terminal window and run the following command:
   java -server -Xms512m -Xmx128g -XX:NewSize=3g -XX:MaxNewSize=3g -XX:SurvivorRatio=8 -XX:+UseG1GC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=60 -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark -verbose:gc -Dwebservice.port=8000 -Dconfig.file=papi.config -jar [PATH TO JAR FILE] server
2. Open a new terminal and execute the bash script.

### With Batch
1. Open a terminal window and run the following command:
   java -server -Xms512m -Xmx128g -XX:NewSize=3g -XX:MaxNewSize=3g -XX:SurvivorRatio=8 -XX:+UseG1GC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=60 -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark -verbose:gc -Dwebservice.port=8000 -Dconfig.file=batch.config -jar [PATH TO JAR FILE] server
2. Open a new terminal and execute the bash script.
