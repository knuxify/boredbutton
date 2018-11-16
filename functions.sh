function aboutb {
    echo "boredbutton $version - the ultimate anti-boredom utility"
    echo "Github: https://github.com/knuxfanwin8/boredbutton"
}


function fdel {
    clear
    echo -e "${warn}### Delete counter data###${white}"
    rm -rf $counterfile
    echo "0" > $counterfile
    echo -e "Done!"
    exit
}

function fdecr {
    clear
    echo -e "${warn}### Decrease counter value ###${white}"
    let ccount--
    echo "$counter" > $counterfile
    echo -e "The current count is now ${warn}$counter${white}."
    exit
}

function fset {
    clear
    echo -e "${warn}### Set counter value ###${white}"
    echo "Input value: (Must be a valid number!)"
    read -re newval
    # prevent the user from inputing an invalid value.
    re='^[0-9]+$'
    if ! [[ $newval =~ $re ]]
    then
        echo -e "${error}[ERROR]${white} Not a number! Please restart ${warn}bored setup${white} and input a valid number."
        exit
    fi
    echo "$newval" > $counterfile
    echo -e "Changed the count to ${warn}$newval${white}!"
    exit
}
function factdel {
    clear
    echo -e "${warn}### Delete the idea list ###${white}"
    rm -rf $list
    echo -e "Done! Please restore the idea list by running ${warn}bored${white}."
    exit
}
function factnew {
    clear
    echo -e "${warn}### New idea ###${white}"
    echo "Checking for existing activities..."
    idcount=$(grep -c 'ID' $list)
    clear
    echo -e "${warn}### Create a new idea ###${white}"
    echo "Welcome to the Idea Creation Wizard."
    echo "Please type in the idea you want to add, for example, 'Write a script'. This is going to appear after 'How about you...', so make sure it fits."
    read -re newactname
    clear
    echo -e "${warn}### Create a new idea ###${white}"
    echo -e "${warn}Done!${white}"
    echo "Now, please type in the idea description, for example, 'Make a cool script that makes your life easier'."
    read -re newactdesc
    clear
    echo -e "${warn}### Create a new idea ###${white}"
    echo -e "${warn}A new idea will be added with the following info:${white}"
    echo -e "Name: ${warn}$newactname${white}"
    echo -e "Description: ${warn}$newactdesc${white}"
    echo -e "If this is correct, press ${warn}Enter${white}. If it's not, press ${warn}Ctrl+C${white}."
    read -ren1
    let idcount++
    echo "ID$idcount" >> $list
    echo "name='$newactname'" >> $list
    echo "desc='$newactdesc'" >> $list
    clear
    echo -e "${warn}### Create a new idea ###${white}"
    echo "Done! Your new idea has been added."
    exit
}
function fpack {
	echo "Not done yet! Should be added in release v1.1."
}
