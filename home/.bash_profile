#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start Hyprland on the first TTY when no graphical session is running.
# Delete this block if you use a display manager instead.
if [[ -z "${WAYLAND_DISPLAY:-}" && "${XDG_VTNR:-}" == 1 ]]; then
	export XDG_CURRENT_DESKTOP=Hyprland
	export XDG_SESSION_TYPE=wayland
	exec Hyprland
fi
