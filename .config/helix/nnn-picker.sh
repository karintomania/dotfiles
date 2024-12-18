
# Use `nnn` in picker mode and output the selected file paths
paths=$(nnn -p -)

if [[ -n "$paths" ]]; then
    zellij action toggle-floating-panes
    zellij action write 27 # send <Escape> key
    zellij action write-chars ":open $paths"
    zellij action write 13 # send <Enter> key
    zellij action toggle-floating-panes
    zellij action close-pane
fi

