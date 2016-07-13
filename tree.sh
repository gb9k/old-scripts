#!/bin/bash

# Prints a simple tree diagram 
# Found this on codecall.net By DarkLordoftheMonkeys

olddir=$PWD;
color="off";

for option in "$@"
do
  case $option in
    --color ) color="on";
    shift;;
    -*    ) shift;;
    *       )      ;;
  esac
done

declare -i stackheight=0;

# stackheight determines the directory depth.
function listfiles {
  cd "$1";
  for file in *

  do
    for ((i=0; $i < $stackheight; i++))
    do
      printf "\t";
    done
    # indentation shows the depth of the file
    if [ -d "$file" ]
    then
      if [ $color == "on" ]
      then
        printf "\e[34m";
        # display directory names in blue
      fi
    fi

    printf "$file\e[0m\n";

    if [ -d "$file" ]
    then
      stackheight=$stackheight+1;
      # more indentation
      listfiles "$file";
      # recursive listing of files
      cd ..;
    fi
  done

  let stackheight=$stackheight-1;
  # less indentation
}

listfiles "$1";
cd $olddir;
unset i color stackheight;
