#!/bin/bash

# Copyright 2016 Google Inc. All rights reserved.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

projectRoot=`dirname $0`/..

DOCKER_NAMESPACE='gcr.io/$PROJECT_ID'
RUNTIME_NAME="openjdk"
CANDIDATE_NAME="8-`date +%Y-%m-%d_%H_%M`"

export IMAGE="${DOCKER_NAMESPACE}/${RUNTIME_NAME}:${CANDIDATE_NAME}"
echo "IMAGE: $IMAGE"

envsubst < $projectRoot/cloudbuild.yaml.in > $projectRoot/target/cloudbuild.yaml

gcloud container builds submit --config=$projectRoot/target/cloudbuild.yaml .

