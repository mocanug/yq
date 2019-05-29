#!/usr/bin/env bash

if [[ "${*}x" == "x" ]]
then
    yaml2json | jq . | json2yaml
else
    yaml2json | jq ${*} | json2yaml
fi