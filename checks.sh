if [ ! -d ~/.bored ]; then boreddebug "making .bored dir" && mkdir ~/.bored; fi
if [ ! -e $list ]; then boreddebug "creating activity list" && cp idealist.txt ~/.bored/ && chmod 777 $list; fi 
if [ ! -e $counterfile ]; then boreddebug "creating counter" && echo "0" > $counterfile && chmod 777 $counterfile; fi
if [ ! -r $list ] || [ ! -w $list ]; then boreddebug "fixing list perms" && chmod 777 $list; fi 
if [ ! -r $counterfile ] || [ ! -w $counterfile ]; then boreddebug "fixing counter perms" && chmod 777 $counterfile; fi
