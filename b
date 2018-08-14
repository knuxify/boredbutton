#!/bin/bash

# b (boredbutton) - An "I'm bored" button.
# Made in bash by knuxfanwin8.

# Default activity list is stored in this variable:
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

# read and write test functions. I moved them to functions since that way they can be accessed at any time.
function readtest {
# check if count.txt if readable.
if [ ! -r ~/.bcount/count.txt ]
then
    echo "Counter data is not readable. Attempting to fix..."
    chmod 777 ~/.bcount/count.txt
    if [ ! -r ~/.bcount/count.txt ]
    then
        sudo chmod 777 ~/.bcount/count.txt
        if [ ! -r ~/.bcount/count.txt ]
        then
            echo "Could not make count.txt readable."
            exit
        fi
    fi
fi
}

function writetest {
# check if count.txt is writeable.
if [ ! -w ~/.bcount/count.txt ]
then
    echo "Counter data not is not writeable. Attempting to fix..."
    chmod 777 ~/.bcount/count.txt
    if [ ! -w ~/.bcount/count.txt ]
    then
        sudo chmod 777 ~/.bcount/count.txt
        if [ ! -w ~/.bcount/count.txt ]
        then
            echo "Could not make count.txt writeable."
            exit
        fi
    fi
fi
}
# Perform tests.
readtest
writetest

# fetch current count
ccount=$(<~/.bcount/count.txt)

# check if ccount is empty. if it isn't, add 1 to it.
if [ -z $ccount ]
then
    ccount=1
else
    let ccount++
fi

# write to file
echo "$ccount" > ~/.bcount/count.txt

#check if write succeded

ccounttest=$(<~/.bcount/count.txt)
if [ ! $ccounttest = $ccount ]
then
    echo "Write failed!"
    echo "Troubleshooting..."
    readtest
    writetest
    echo "Retrying..."
    echo "$ccount" > ~/.bcount/count.txt
    if [ ! $ccounttest = $ccount ]
    then
        echo "Failed. Retrying with sudo..."
        sudo echo "$ccount" > ~/.bcount/count.txt
        if [ ! $ccounttest = $ccount ]
        then
            echo "Failed to write. Exiting..."
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
            echo -e "Invalid line! Ignoring. Line content:\n$line"
        fi
        fi
    fi
done < "$filename"
idcount="${currentid:2}"

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
echo "So you're bored, right? How about you:"
echo "${!readablename:$rnamelenght}"
echo "${!readabledesc:$rdesclenght}"

