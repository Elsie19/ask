ask() {
    local prompt default reply

    if [[ ${2:-} = 'Y' ]]; then
        prompt="${GREEN}Y${NC}/${RED}n${NC}"
        default='Y'
    elif [[ ${2:-} = 'N' ]]; then
        prompt="${GREEN}y${NC}/${RED}N${NC}"
        default='N'
    else
        prompt="${GREEN}y${NC}/${RED}n${NC}"
        default=''
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read -r reply </dev/tty

        # Default?
        if [[ -z $reply ]]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}
