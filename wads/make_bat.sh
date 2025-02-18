#!/usr/bin/bash

# pro doom2.exe udela batky podle vsech *.wad v adresari

rm -f ../*.BAT

ls *.WAD | awk -F'.' '{print "touch "$1".BAT"}' > tmp
bash < tmp

ls *.WAD | awk -F'.' '{print "echo @echo off >> "$1".BAT"}' > tmp
bash < tmp

ls *.WAD | awk -F'.' '{print "echo edit c:\\\\hry\\\\doom2\\\\wads\\\\"$1".txt"" >> " $1".BAT"}' > tmp
bash < tmp

ls *.WAD | awk -F'.' '{print "echo doom2.exe -file wads/"$1"."$2" >> " $1".BAT"}' > tmp
bash < tmp

ls *.WAD | awk -F'.' '{print "echo @echo off >> "$1".BAT"}' > tmp
bash < tmp

rm tmp

mv *.BAT ../




