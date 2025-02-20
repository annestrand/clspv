#!/bin/bash
# Copyright 2019 The Clspv Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd )"
ROOT_DIR=$(cd "$SCRIPT_DIR"/../.. >/dev/null 2>&1 && pwd)

# Fail on any error.
set -e
# Display commands being run.
set -x

docker run --rm -i \
  --volume "${ROOT_DIR}:${ROOT_DIR}" \
  --workdir "${ROOT_DIR}" \
  "us-east4-docker.pkg.dev/shaderc-build/radial-docker/ubuntu-24.04-amd64/formatter" \
  "${SCRIPT_DIR}/build-docker.sh" FULL
