if [ "$arg" = "--about" ] || [ "$arg2" = "--about" ]; then aboutb && exit; fi
if [ "$arg" = "--debug" ] || [ "$arg2" = "--debug" ]; then debug=true; else debug=false; fi 
if [ "$arg" = "setup" ] || [ "$arg2" = "setup" ]; then setup=1 && setup; else setup=0; fi
if [ "$arg" = "ideaman" ] || [ "$arg2" = "ideaman" ]; then ideaman; fi
lookfor=f$arg
lookfor2=f$arg2
if [ "$(type -t $lookfor)" = "function" ]; then $lookfor; fi
if [ "$(type -t $lookfor2)" = "function" ]; then $lookfor2; fi
