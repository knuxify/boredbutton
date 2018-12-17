boreddebug "Starting setup utility..."
while true
do
    clear
	echo -e "${warn}boredbutton ${menuname}$version"
	echo -e "${white}You used the button ${warn}$counter${white} times."
	echo -e "\n${menuname}### Counter options ###${white}\n"
	echo -e "${menuname}Remove counter data${white} - ${warn}del${white}."
	echo -e "${menuname}Decrease counter by 1${white} - ${warn}decr${white}."
	echo -e "${menuname}Set counter value${white} - ${warn}set${white}."
	echo -e "\n${menuname}### Idea options ###${white}\n"
	echo -e "${menuname}Idea manager (view ideas, edit, delete, create)${white} - ${warn}ideaman${white}."
	echo -e "${menuname}Remove all ideas${white} - ${warn}actdel${white}."
	echo -e "${menuname}Package idea list for distribution${white} - ${warn}packmake${white}"
	echo -e "${menuname}Load an idea list${white} - ${warn}packload${white}"
    echo -e "\n${menuname}Note: ${white}To recreate idea data, run ${warn}bored${white}."
    echo -e "\n${menuname}### Updater ###${white}\n"
	if [ "$updatertoggle" = "1" ]; then echo -e "${warn}Updater: ${menuname}ON${white}"; else echo -e "${warn}Updater: ${menuname}OFF${white}"; fi
	echo -e "${menuname}Toggle updater on/off${white} - ${warn}updatertoggle${white}."
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
			if [ "$choice" = "ideaman" ]; then ideaman; exit
			else exit; fi
    	fi
	else
		exit
	fi
done
exit
