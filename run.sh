#!/bin/sh

swipl -q -t halt -s src/main.pl -- "$*"
