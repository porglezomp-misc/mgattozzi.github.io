#!/bin/bash
#Part of a script that autogenerates the website from the top level
cd ../sass
for file in $(ls | grep scss)
do
  sass $file ../css/$(ls $file|awk -F'[_.]' '{print $1}').css
done
