#!/bin/sh

clear
swipl -q -t halt -s src/main.pl -- "$*"
