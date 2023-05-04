#!/bin/sh

# clear
# cat 'resources/lv1.txt' | time swipl -q src/main.pl -- --solve
# cat 'resources/lv2.txt' | time swipl -q -s src/main.pl -- --solve
swipl -q -t halt -s src/main.pl -- --game=[resources/lv2.txt]
