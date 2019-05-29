#!/usr/bin/env bash

if [[ "${*}x" == "x" ]]
then
    jq . | json2yaml
else
    jq ${*} | json2yaml
fi
