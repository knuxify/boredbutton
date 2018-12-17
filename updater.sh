function boredupdater {
	echo -e "${white}Checking for updates..."
	updateraw=$(curl -s https://knuxfanwin8.github.io/softversions/index.html | grep "boredbutton")
	boreddebug "..."
	update=${updateraw:12:-4}
	updatenum="${updateraw//boredbutton $update /}"
	echo "fetched update version $update ($updatenum)"
	if [ -z "$updateraw" ]
	then
		boreddebug "No internet! Skipping update."
	else
		if [ "$version" = "$update" ]
		then
			echo "No updates available."
		else
			if [ "$versionnum" -lt "$updatenum" ]
			then
				echo -e "${white}An update is available."
				echo -e "Current version: ${warn}$version ($versionnum)${white}"
				echo -e "Newest version: ${warn}$update ($updatenum)${white}"
				if hash git 2>/dev/null; then				
					echo "To install it, press 'y'."
					read -ren1 option
					if [ "$option" = "y" ] || [ "$option" = "Y" ]
					then
						clear
						echo "[=   ]"
						echo "Preparing..."
						rm -rf ~/.bored/update
						mkdir ~/.bored/update
						clear
						echo "[==  ]"
						echo "Downloading new version..."
						git clone --branch $version https://github.com/knuxfanwin8/boredbutton ~/.bored/update &>/dev/null
						clear
						echo "[=== ]"
						echo "Installing new version..."
						~/.bored/update/install --skipconfirm &>/dev/null
						clear
						echo "[====]"
						echo "Done!"
						echo "Please run bored again"
						exit
					fi
				else
					echo "You can download it from the github repository."
				fi		
			else
				echo "Something went wrong!"
				echo "Are you a time traveler, or just screwing with the files?"	
			fi
		fi
	fi
}
noupdate=0
if ! hash curl 2>/dev/null; then
	echo -e "${warn}[NOTE]${white} curl is not installed! Update check will be skipped."
	echo "To disable the updater use 'bored updatertoggle'."
	noupdate=1
else
if ! hash wget 2>/dev/null
then
	echo -e "${warn}[NOTE]${white} wget is not installed! Internet connection check will be skipped."
	echo "To disable the updater (including the connection check) use 'bored updatertoggle'."
	noupdate=1
else
	boreddebug "fetch update"
	wget -q --spider http://knuxfanwin8.github.io/softversions/index.html
	if [ $? -eq 0 ] && [ "$noupdate" = "0" ]; then
    	boredupdater
	fi
fi
fi
