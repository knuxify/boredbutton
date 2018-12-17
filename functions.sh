function aboutb {
    echo "boredbutton $version - the ultimate anti-boredom utility"
    echo "Github: https://github.com/knuxfanwin8/boredbutton"
}

function fupdatertoggle {
	if [ "$updatertoggle" = "1" ]; then echo "0" > ~/.bored/updater; else echo "1" > ~/.bored/updater; fi
	clear
	echo "Done!"
	exit
}

function fprintact {
	cat ~/.bored/idealist.txt
	exit
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
    echo 'name="'"$newactname"'"' >> $list
    echo 'desc="'"$newactdesc"'"' >> $list
    clear
    echo -e "${warn}### Create a new idea ###${white}"
    echo "Done! Your new idea has been added."
    exit
}
function fpackmake {
	clear
	echo -e "${warn}### Package idea lists ###${white}"
	echo -e "Type in the directory in which the package should be placed."
	echo "Note: this will overwrite any file with this name."
	read -re packdir
	packdir=${packdir/'~'/$HOME}
	if [ -z $packdir ]; then
		packdir=$PWD/package.bored
	fi	
	if [ -d $packdir ]; then
		packdir=$packdir/package.bored
	fi
	clear
	echo "Preparing..."
	grep -v -x -f ~/.bored/defaultnoid.txt ~/.bored/idealist.txt | sed '/^ID/ d' > $packdir
	boreddebug "$(cat $packdir)"
	clear
	echo "Done! Saved in $packdir."
	exit
}
function fpackload {
	clear
	echo -e "${warn}### Load package ###${white}"
	echo -e "Type in the package's location."
	read -re packdir
	if [ -z $packdir ]; then
		packdir=$PWD/package.bored
	fi	
	if [ -d $packdir ]; then
		packdir=$packdir/package.bored
	fi
	packdir=${packdir/'~'/$HOME}
	# BEGIN
		idcount=$(grep -c 'ID' $list)
		boreddebug "$idcount" 
		cp -f $packdir ~/.bored/packtmp &> /dev/null
		while IFS= read -r line
		do
			boreddebug "Reading line $line..."
			if [[ "$line" == "name="* ]] && ! grep -q "$line" ~/.bored/idealist.txt
			then
				boreddebug "--! Line contains name: $line"
				let idcount++
				boreddebug "ID count now: $idcount"
				grep -A1 "$line" ~/.bored/packtmp > ~/.bored/packtmpf
				sed "/$line/ { N; s/$line/ID$idcount\n&/ }" ~/.bored/packtmpf >> ~/.bored/idealist.txt
			fi
		done < "$HOME/.bored/packtmp"
		boreddebug "$(cat ~/.bored/packtmp)"
		rm -f ~/.bored/packtmp
		rm -f ~/.bored/packtmpf
	# END
	echo "Done!"
	exit
}
