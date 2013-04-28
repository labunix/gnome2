#!/bin/bash

# gconftool-2 version bigger than 2.28
CHECK=`gconftool-2 -v | awk '($1>2.28){print}' | wc -l`

if [ "$CHECK" -le "0" ];then
  echo "ERROR: Check Your \"gconftool-2\"" >&2
  dpkg -l gconf2 
  exit 1
fi

FLAG=false

REGDIR=/apps/nautilus/desktop

if [ "$1" == "-d" ];then
  echo "[before]"
  gconftool-2 --all-entries /apps/nautilus/desktop
fi

for key in trash_icon_visible home_icon_visible computer_icon_visible;do
  if [ "$FLAG" == "`gconftool-2 --get ${REGDIR}/${key}`" ];then
    gconftool-2 --set ${REGDIR}/${key} --type bool true
  else
    gconftool-2 --set ${REGDIR}/${key} --type bool false
  fi
done

if [ "$1" == "-d" ];then
  echo "[after]"
  gconftool-2 --all-entries /apps/nautilus/desktop
fi

echo `seq 1 30` | sed s/"[0-9]*"/"#"/g | tr -d ' '
echo -e "\nPlease,relogin,gnome!\n"
echo `seq 1 30` | sed s/"[0-9]*"/"#"/g | tr -d ' '
unset REGDIR FLAG key CHECK
exit 0
