function boreddebug {
    if [ $debug = "true" ]; then echo -e "${error}DEBUG: ${white}$@"; fi
}
