#!/bin/bash

# shellcheck disable=SC2068
layer_wrapper --layers=python3_circus@mfext -- _circus_schedule_start_watcher.py $@
