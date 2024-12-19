paths=$(xclip -o -selection c)

if [[ -e "$paths" ]]; then
    zellij action toggle-floating-panes
    zellij action write 27 # send <Escape> key
    zellij action write-chars ":open $paths"
    zellij action write 13 # send <Enter> key
fi

