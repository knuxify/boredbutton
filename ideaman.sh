function ideamanedit {
	clear
	grep -v "ID" ~/.bored/tmp > ~/.bored/tmp2
	cat ~/.bored/tmp2 > ~/.bored/tmp
	source ~/.bored/tmp
	echo "Type in a new name (leave empty to keep old name):"
	read -re newname
	if ! [ -z "$newname" ]; then name="$newname"; fi
	echo "Type in a new description (leave empty to keep old description):"
	read -re newdesc
	if ! [ -z "$newdesc" ]; then desc="$newdesc"; fi
	clear
	echo "ID$idpick" > ~/.bored/tmp
	echo 'name="'"$name"'"' >> ~/.bored/tmp
	echo 'desc="'"$desc"'"' >> ~/.bored/tmp
	boreddebug "$(cat ~/.bored/tmp)"
	source ~/.bored/tmp &> /dev/null
	echo "New settings:"
	while read line; do
  		if echo "$line" | grep -q "ID"; then echo -e "$error$line"; fi
		if echo "$line" | grep -q "name"; then echo -e "$warn- Name: $white${line:5}"; fi
		if echo "$line" | grep -q "desc"; then echo -e "$warn- Description: $white${line:5}"; fi
	done <~/.bored/tmp
	echo "If this is ok, press any button. If it isn't, press Ctrl+C."
	read -ren1
	clear
	boreddebug "Begin saving..."
	boreddebug "sed for lines"
	sed -i "/ID$idpick/,+2d" ~/.bored/idealist.txt
	boreddebug "Add new lines"
	cat ~/.bored/tmp >> ~/.bored/idealist.txt
	echo "Done!"
	exit
}
function ideamandel {
	echo -e "${error}ARE YOU SURE YOU WANT TO DO THIS?${white}"
	echo "If this is ok, press any button. If it isn't, press Ctrl+C."
	read -ren1
	clear
	boreddebug "Begin deletion process..."
	boreddebug "sed for lines"
	sed -i "/ID$idpick/,+2d" ~/.bored/idealist.txt
	boreddebug "Fix the IDs"
	currentline=0
	printf "" > ~/.bored/tmp2
	while read line; do
		let currentline++
		if echo "$line" | grep -q "ID"; then
			let idparsed++
			if [ "$idparsed" -gt "$idpick" ] || [ "$idparsed" = "$idpick" ]; then
				sed -i '/ID$idparsed/,+2d' ~/.bored/idealist.txt
				sed -i "${currentline}s/.*/ID${idparsed}/" ~/.bored/idealist.txt
			fi
		fi
	done <~/.bored/idealist.txt
	cat ~/.bored/tmp2
	echo "Done!"
	exit
}
function ideaman {
	clear
	menuloop=0
	echo "Ideas:"
	while read line; do
  		if echo "$line" | grep -q "ID"; then echo -e "$error$line"; fi
		if echo "$line" | grep -q "name"; then echo -e "$warn- Name: $white${line:5}"; fi
		if echo "$line" | grep -q "desc"; then echo -e "$warn- Description: $white${line:5}"; fi
	done <~/.bored/idealist.txt
	echo "Type in the ID of the idea you want to edit. Type in anything else to create a new idea."
while [ "$menuloop" = "0" ]; do
	read -re idpick
	idpick=${idpick//ID/}
	boreddebug "$idpick"
	grep -A2 ID$idpick $list > ~/.bored/tmp
	boreddebug "$(cat ~/.bored/tmp)"
	re='^[0-9]+$'
	if [ -z "$(cat ~/.bored/tmp)" ] || [ -z "$idpick" ] || ! [[ $idpick =~ $re ]]; then
		factnew
	else 
		menuloop=1
	fi
done
	clear
	while read line; do
  		if echo "$line" | grep -q "ID"; then echo -e "$error$line"; fi
		if echo "$line" | grep -q "name"; then echo -e "$warn- Name: $white${line:5}"; fi
		if echo "$line" | grep -q "desc"; then echo -e "$warn- Description: $white${line:5}"; fi
	done <~/.bored/tmp
	while [ "$menuloop" = "1" ]; do
	echo "### Pick an option. ###"
	echo -e "${warn}Edit this idea${white} - edit"
	echo -e "${warn}Delete this idea${white} - del"
	echo -e "${warn}Exit${white} - exit"
	read -re menuoption
	if ! [ "$menuoption" = "edit" ] && ! [ "$menuoption" = "del" ] && ! [ "$menuoption" = "exit" ]; then
		echo "Wrong option!"
	else
		menuloop=2
	fi
	done
	if [ "$menuoption" = "exit" ]; then exit; else ideaman$menuoption; fi
}
