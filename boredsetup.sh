boreddebug "Starting setup utility..."
while true
do
    clear
	echo -e "${white}You used the button ${warn}$counter${white} times."
	echo -e "\n${menuname}### Counter options ###${white}\n"
	echo -e "${menuname}Remove counter data${white} - ${warn}del${white}."
	echo -e "${menuname}Decrease counter by 1${white} - ${warn}decr${white}."
	echo -e "${menuname}Set counter value${white} - ${warn}set${white}."
	echo -e "\n${menuname}### Idea options ###${white}\n"
	echo -e "${menuname}Remove idea data${white} - ${warn}actdel${white}."
	echo -e "${menuname}Create a new idea${white} - ${warn}actnew${white}."
	echo -e "${menuname}Print all ideas${white} - ${warn}printact${white}."
	echo -e "${menuname}Package idea list for distribution${white} - ${warn}packmake${white}"
	echo -e "${menuname}Load an idea list${white} - ${warn}packload${white}"
    echo -e "\n${menuname}Note: ${white}To recreate idea data, run ${warn}bored${white}."
    echo -e "\n${menuname}### Exit ###${white}\n"
	echo -e "To exit, type anything else or just press Enter."
	echo -e "\n${menuname}######################${white}"
	read -re choice
    boreddebug "Choice: $choice"
	lookfor=f$choice
	if ! [ -z $choice ]
	then
    	if [ "$(type -t $lookfor)" = "function" ]
    	then
        	$lookfor
		else
			exit
    	fi
	else
		exit
	fi
done
exit
