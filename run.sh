#!/bin/sh


# swipl src/main.pl -- --game=[resources/lv2.txt]

cat 'resources/lv1.txt' | time swipl -q src/main.pl -- --solve
cat 'resources/lv2.txt' | time swipl -q src/main.pl -- --solve
cat 'resources/lv3.txt' | time swipl -q src/main.pl -- --solve

swipl src/main.pl -- --gen=[2,4,8]

cat 'resources/test1.txt' | swipl -q src/main.pl -- --test=[6,\'D\']

swipl -t halt -s src/main.pl -- --plu

