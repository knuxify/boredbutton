#!/bin/bash

#check if count.txt exists. if not, make a file called count.txt with the content 1.
if [ ! -f ~/.bcount/count.txt ]; then
    # to prevent "directory exists" error:
    if [ ! -e ~/.bcount/ ]
    then
        mkdir ~/.bcount
    fi
    echo "1" > ~/.bcount/count.txt
    echo "I'm bored!"
    exit
fi

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

echo "I'm bored!"
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


