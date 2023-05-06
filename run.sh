#!/bin/sh

clear
swipl -t halt -q -s src/main.pl -- --gen=[2,4,4]

# cat 'resources/lv1.txt' | time swipl -q src/main.pl -- --solve
# cat 'resources/lv2.txt' | time swipl -q -s src/main.pl -- --solve
# swipl -q -t halt -s src/main.pl -- --game=[resources/lv2.txt]
