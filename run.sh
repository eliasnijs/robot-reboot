#!/bin/sh

clear
# cat 'resources/lv0.txt' | swipl -q src/main.pl -- --solve
# cat 'resources/lv2.txt' | swipl -q -t halt -s src/main.pl -- --solve
swipl -q -t halt -s src/main.pl -- --game=[resources/lv0.txt]
