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
# Current version: v0.6
# Feel free to fork and modify the code, as long as you don't claim it as your own!
###############################
# Have a good idea for an activity? Post it in an issue in the GitHub repo!
# Want to improve the code? Fork the repo, and make a pull request!
###############################

# Color variables
white='\033[1;37m'
error='\033[0;31m'
warn='\033[1;33m'

# The default activity list is stored in this variable:
dactlist='ID1\nname=Write a Bash script!\ndesc=How about a fix to that one problem you keep getting and fixing with one command?\nID2\nname=Try building some program! (or something out of Lego bricks, that will do too!)\ndesc=Maybe you can find the source of your favorite program and try to compile it. Freshest code and fixes guaranteed.\nID3\nname=Try making a funny website!\ndesc=Or a serious website. Either way, try your hand at web design.\nID4\nname=Try flashing a ROM on your old phones.\ndesc=Remember that old phone that has been sitting in your drawer for a few years? Give it a new life with a custom ROM. If you cannot find one, make it yourself!'

# Activity list location:
homedir=~/
filename="$homedir.bcount/actlist.txt"

# Check if counter data exists. If not, make it.
if [ ! -f ~/.bcount/count.txt ]; then
    # to prevent directory exists error:
    if [ ! -e ~/.bcount/ ]
    then
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
if [ ! -r ~/.bcount/count.txt ]
then
    echo -e "${error}[ERROR]${white} Counter data is not readable. Attempting to fix..."
    chmod 777 ~/.bcount/count.txt
    if [ ! -r ~/.bcount/count.txt ]
    then
        sudo chmod 777 ~/.bcount/count.txt
        if [ ! -r ~/.bcount/count.txt ]
        then
            echo -e "${error}[CRITICAL ERROR]${white} Could not make counter data readable. Exiting..."
            exit
        fi
    fi
fi
}

# Counter data write test (this shouldn't happen, since read test above also fixes the counter.txt, but just in case...)

function writetest {
if [ ! -w ~/.bcount/count.txt ]
then
    echo -e "${error}[ERROR]${white} Counter data not is not writeable. Attempting to fix..."
    chmod 777 ~/.bcount/count.txt
    if [ ! -w ~/.bcount/count.txt ]
    then
        sudo chmod 777 ~/.bcount/count.txt
        if [ ! -w ~/.bcount/count.txt ]
        then
            echo -e "${error}[CRITICAL ERROR]${white} Could not make count.txt writeable. Exiting..."
            exit
        fi
    fi
fi
}

# Activity list read test

function actreadtest {
if [ ! -r ~/.bcount/actlist.txt ]
then
    echo -e "${error}[ERROR]${white} The activity list is not readable. Attempting to fix..."
    chmod 777 ~/.bcount/actlist.txt
    if [ ! -r ~/.bcount/actlist.txt ]
    then
        sudo chmod 777 ~/.bcount/actlist.txt
        if [ ! -r ~/.bcount/actlist.txt ]
        then
            echo -e "${error}[CRITICAL ERROR]${white} Could not make the activity list readable. Exiting..."
            exit
        fi
    fi
    echo -e "Done!\n"
fi
}

# Perform tests.
readtest
writetest
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
    writetest
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
echo -e "${warn}###${white}"
echo -e "${white}So you're bored, right? How about you:"
echo "${!readablename:$rnamelenght}"
echo "${!readabledesc:$rdesclenght}"

