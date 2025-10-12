#!/usr/bin/bash

echo -n "2016: "
cat ~/exercice1/ann/2016/*.ann | grep "Location" | wc -l

echo -n "2017: "
cat ~/exercice1/ann/2017/*.ann | grep "Location" | wc -l

echo -n "2018: "
cat ~/exercice1/ann/2018/*.ann | grep "Location" | wc -l
