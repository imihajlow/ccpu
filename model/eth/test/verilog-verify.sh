#!/bin/bash

if $1 | rg --passthru FATAL
then
    exit 1
else
    exit 0
fi
