#!/usr/bin/env bash
# Point ~/.config and a few home files at this repo.
# Anything already in the way is moved to ~/.local/state/dotfiles-backup-<date>/.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP="$HOME/.local/state/dotfiles-backup-$(date +%Y%m%d-%H%M%S-%N)"
made_backup=0

backup_dest() {
	local dest="$1"
	local rel="${dest#"$HOME"/}"
	mkdir -p "$BACKUP/$(dirname "$rel")"
	mv "$dest" "$BACKUP/$rel"
	made_backup=1
}

link() {
	local src="$1"
	local dest="$2"
	mkdir -p "$(dirname "$dest")"
	if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
		return
	fi
	if [[ -e "$dest" || -L "$dest" ]]; then
		backup_dest "$dest"
	fi
	ln -sfn "$src" "$dest"
	echo "linked $dest"
}

for name in hypr nvim waybar wofi alacritty gtk-3.0 gtk-4.0 nwg-look xsettingsd backgrounds mako; do
	link "$ROOT/config/$name" "$CONFIG/$name"
done
link "$ROOT/config/starship.toml" "$CONFIG/starship.toml"
link "$ROOT/home/.bashrc" "$HOME/.bashrc"
link "$ROOT/home/.bash_profile" "$HOME/.bash_profile"
link "$ROOT/home/.gitconfig" "$HOME/.gitconfig"

if ((made_backup)); then
	echo "Previous files were moved to $BACKUP"
fi
