if [ ! -d ~/.bored ]; then boreddebug "making .bored dir" && mkdir ~/.bored; fi
if [ ! -e $list ] || [ -z "$(cat $list)" ]; then boreddebug "creating activity list" && cp -f ~/.bored/defaultlist.txt ~/.bored/idealist.txt && chmod 777 $list; fi 
if [ ! -e $counterfile ]; then boreddebug "creating counter" && echo "0" > $counterfile && chmod 777 $counterfile; fi
if [ ! -e ~/.bored/updater ]; then boreddebug "creating updater toggle" && echo "0" > ~/.bored/updater && chmod 777 ~/.bored/updater; fi
if [ ! -r $list ] || [ ! -w $list ]; then boreddebug "fixing list perms" && chmod 777 $list; fi 
if [ ! -r $counterfile ] || [ ! -w $counterfile ]; then boreddebug "fixing counter perms" && chmod 777 $counterfile; fi
