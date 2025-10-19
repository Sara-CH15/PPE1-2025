#!/usr/bin/bash


for annee in 2016 2017 2018; do
    echo -n "$annee: "
    cat ~/exercice1/ann/"$annee"/*.ann | grep "Location" | wc -l
done
