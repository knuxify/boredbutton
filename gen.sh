# Increase counter by 1.
let counter++
echo "$counter" > $counterfile
boreddebug "$counter saved to $counterfile"
# Display some info
echo -e "${white}boredbutton ${warn}$version${white} | do ${menuname}'bored setup'${white} for utilities | you used the button ${warn}$counter${white} times"
# Pick a random ID.
randomid=$(awk -v min=1 -v max=$idcount 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
boreddebug "random id: $randomid"
# Get the entry.
grep -A2 ID$randomid $list > ~/.bored/tmp
if [ -z "$(cat ~/.bored/tmp)" ]
then
	echo "ID $randomid not found!"
	echo "Have you been tampering with the idea list manually?"
	echo "Read this for more information:"
	echo "https://github.com/knuxfanwin8/boredbutton/wiki/Idea-lists"
	exit
fi
source ~/.bored/tmp &> /dev/null
boreddebug "$(cat ~/.bored/tmp)"
# Output everything.
echo -e "${randomcolor}###${white}"
echo -e "${white}So you're bored, right? How about you:"
echo -e "${randomcolor}${name}${white}"
echo "${desc}"
