#!/bin/sh


# swipl src/main.pl -- --game=[resources/lv2.txt]

cat 'resources/lv1.txt' | time swipl src/main.pl -- --solve
cat 'resources/lv2.txt' | time swipl src/main.pl -- --solve
cat 'resources/lv3.txt' | time swipl src/main.pl -- --solve

swipl src/main.pl -- --gen=[2,4,8]

cat 'resources/lv1.txt' | swipl src/main.pl -- --test=[0,\'U\']

