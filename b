#!/bin/bash

#############################
#    ____________________   #
#   /    boredbutton    /|  #
#  /   by knuxfanwin8  / |  #
#  \  ################ \ |  #
#   \___________________\|  #
#                           #
#############################
# Github: https://github.com/knuxfanwin8/boredbutton
# Current version: v0.7
# Feel free to fork and modify the code, as long as you don't claim it as your own!
###############################
# Have a good idea for an activity? Post it in an issue in the GitHub repo!
# Want to improve the code? Fork the repo, and make a pull request!
###############################
version="v0.7"

# Color variables
white='\033[1;37m'
error='\033[0;31m'
warn='\033[1;33m'
randomcolor="\033[38;5;$(awk -v min=17 -v max=231 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')m"

# The default activity list is stored in this variable:
dactlist='ID1\nname=Write a Bash script!\ndesc=How about a fix to that one problem you keep getting and fixing with one command?\nID2\nname=Try building your favorite programs yourself!\ndesc=Maybe you can find the source of your favorite program and try to compile it. Freshest code and fixes guaranteed.\nID3\nname=Try making a funny website!\ndesc=Or a serious website. Either way, try your hand at web design.\nID4\nname=Try flashing a ROM on your old phone.\ndesc=Remember that old phone that has been sitting in your drawer for a few years? Give it a new life with a custom ROM. If you cannot find one, make it yourself!\nID5\nname=Try to make some friends!\ndesc=Find some people you could talk to, or communities for people with simmilar interests.\nID6\nname=Read the news\ndesc=You could read stuff about your favorite topics. It can be great fun and helps you stay up-to-date.\nID7\nname=Make your own boredbutton entries!\ndesc=You can submit your own boredbutton entries by creating an issue in the github repo (you can find the link by using b --about or opening the file).\nID8\nname=Finish your old projects.\ndesc=You might have some ideas you never brought to life. It is time to fulfill your dreams!\nID9\nname=Make a list of stuff you want.\ndesc=Maybe you want a new graphics card, a phone, or just a snack. Make a list of things you want to get. Maybe you can find exact models that you want.'
# Example: IDX\nname=NAME\ndesc=DESC\n
# where x is the last id + 1

# Activity list location:
homedir=~/
filename="$homedir.bcount/actlist.txt"

# If the --about argument was passed, print some info and exit.
if [ ! -z "$1" ]
then
    if [ "$1" = "--about" ]
    then
        echo -e "${white}Github: https://github.com/knuxfanwin8/boredbutton"
        echo "Current version: $version"
        echo "Feel free to fork and modify the code, as long as you don't claim it as your own!"
        echo -e "${randomcolor}###${white}"
        echo "Have a good idea for an activity? Post it in an issue in the GitHub repo!"
        echo "Want to improve the code? Fork the repo, and make a pull request!"
        exit
    fi
fi

# Check if counter data exists. If not, make it.
if [ ! -f ~/.bcount/count.txt ]; then
    # to prevent directory exists error:
    if [ ! -e ~/.bcount/ ]; then 
        mkdir ~/.bcount
    fi
    echo "0" > ~/.bcount/count.txt
fi

# Check if the activity list is present. If not, fill it.
if [ ! -f ~/.bcount/actlist.txt ]; then 
    echo -e "$dactlist" > ~/.bcount/actlist.txt
fi

# Read and write test functions. I moved them to functions since that way they can be accessed at any time.

# Counter data read test

function readtest {
if [ ! -r "$homedir.bcount/count.txt" ] || [ ! -w "$homedir.bcount/count.txt" ]
then
    echo -e "${white}Fixing counter data..."
    chmod 777 ~/.bcount/count.txt
    if [ ! -r "$homedir.bcount/count.txt" ] || [ ! -w "$homedir.bcount/count.txt" ]
    then
        sudo chmod 777 ~/.bcount/count.txt
        if [ ! -r "$homedir.bcount/count.txt" ] || [ ! -w "$homedir.bcount/count.txt" ]
        then
            echo -e "${error}[CRITICAL ERROR]${white} Could not fix counter data."
            exit
        fi
    fi
fi
}

# Activity list read test

function actreadtest {
if [ ! -r "$homedir.bcount/actlist.txt" ]
then
    echo -e "${white}Fixing activity data..."
    chmod 777 ~/.bcount/actlist.txt
    if [ ! -r "$homedir.bcount/actlist.txt" ]
    then
        sudo chmod 777 ~/.bcount/actlist.txt
        if [ ! -r "$homedir.bcount/actlist.txt" ]
        then
            echo -e "${error}[CRITICAL ERROR]${white} Could not fix activity data."
            exit
        fi
    fi
fi
}

# Perform tests.
readtest
actreadtest

# Fetch current counter data.
ccount=$(<~/.bcount/count.txt)

# Check if the counter data is empty, then, add 1 to it.
if [ -z $ccount ]
then
    ccount=1
else
    let ccount++
fi

# Write new counter data to the counter data file.
echo "$ccount" > ~/.bcount/count.txt

# Check if the write succeded.
ccounttest=$(<~/.bcount/count.txt)
if [ ! $ccounttest = $ccount ]
then
    echo -e "${error}[ERROR]${white} Write failed!"
    echo "Troubleshooting..."
    readtest
    echo "Retrying..."
    echo "$ccount" > ~/.bcount/count.txt
    if [ ! $ccounttest = $ccount ]
    then
        echo -e "${error}[ERROR]${white} Failed. Retrying with sudo..."
        sudo echo "$ccount" > ~/.bcount/count.txt
        if [ ! $ccounttest = $ccount ]
        then
            echo -e "${error}[CRITICAL ERROR]${white} Failed to write. Exiting..."
            exit
        fi
    fi
    echo "Done!"
fi

# Parse activities.
varname="name"
vardesc="desc"
currentid="0"
while read -r line
do
    if [[ $line == ID* ]]
    then
        currentid=$line
        let practicalidcount++
    else
        if [[ $line == name=* ]]
        then
            line="${line:5}"
            makeline=$currentid$varname
            declare "$makeline=$makeline$line"
        else
        if [[ $line == desc=* ]]
        then
            line="${line:5}"
            makeline=$currentid$vardesc
            declare "$makeline=$makeline$line"
        else
            echo -e "${warn}[WARN]${white} Invalid line! Ignoring. Line content:\n$line"
        fi
        fi
    fi
done < "$filename"
idcount="${currentid:2}"
if [ ! $practicalidcount -eq $idcount ]
then
    echo -e "${error}[CRITICAL ERROR]${white} The total number of IDs is different from the highest ID."
    echo "If you made modifications to the activity list, make sure the IDs are in order (e.g. ID1, ID2, ID3 and not ID1, ID3, ID2 or ID1, ID3)."
    exit
fi
# Pick a random ID.
randomid=$(( ( RANDOM % $idcount )  + 1 ))
if [ $randomid = "0" ]
then
    randomid=1
fi

# Turn the ID into a full ID.
randomid="ID$randomid"
readablename="$randomid""name"
readabledesc="$randomid""desc"
rnamelenght=${#readablename}
rdesclenght=${#readabledesc}

# Output everything.
echo -e "${randomcolor}###${white}"
echo -e "${white}So you're bored, right? How about you:"
echo "${!readablename:$rnamelenght}"
echo "${!readabledesc:$rdesclenght}"

