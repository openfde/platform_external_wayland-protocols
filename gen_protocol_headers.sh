#!/bin/bash
# Copyright (C) 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [[ $# -lt 3 ]]; then
  echo "Usage: gen_protocol_headers.sh <path_to_wayland_scanner> <out_dir> \
<protocol_1> <protocol_2> ..."
  exit 1
fi

set -e
wayland_scanner="$1"
out_dir="$2"
shift 2
protocols=( "$@" )

for protocol in "${protocols[@]}"; do
  filename="${protocol##*/}"
  header="${filename%.xml}-client-protocol.h"
  "${wayland_scanner}" client-header < "${protocol}" > "${out_dir}/${header}"
done
