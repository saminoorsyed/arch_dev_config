#!/usr/bin/env bash
# Install packages from ./packages, then link this repo into the home directory.
# Edit the package lists before you run this. Re-running is safe.
# Drop --noconfirm below if you want pacman and yay to ask first.

# Node release line. 26 tracks the current 26.x release (Arch's nodejs package
# is on this line). nvm's old 26.2.0 install is not what this pins.
NODE_VERSION=26

set -euo pipefail

if [[ "${EUID}" -eq 0 ]]; then
	echo "Run this as your user, not root. The script calls sudo when it needs it." >&2
	exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
	echo "This script is for Arch Linux (pacman was not found)." >&2
	exit 1
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

packages_in() {
	grep -vE '^[[:space:]]*(#|$)' "$1" | sed -E 's/[[:space:]]+#.*$//' | sed '/^[[:space:]]*$/d'
}

mapfile -t official < <(packages_in "$ROOT/packages/pacman.txt"; packages_in "$ROOT/packages/dev.txt")
if ((${#official[@]})); then
	sudo pacman -Syu --needed --noconfirm -- "${official[@]}"
fi

if ! command -v yay >/dev/null 2>&1; then
	tmp="$(mktemp -d)"
	git clone --depth 1 https://aur.archlinux.org/yay.git "$tmp/yay"
	(cd "$tmp/yay" && makepkg -si --noconfirm)
	rm -rf "$tmp"
fi

mapfile -t aur < <(packages_in "$ROOT/packages/aur.txt")
if ((${#aur[@]})); then
	yay -S --needed --noconfirm --answerdiff None --answerclean None -- "${aur[@]}"
fi

sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now docker.service
sudo usermod -aG docker "$USER"

user_units=(
	pipewire.socket
	pipewire-pulse.socket
	wireplumber.service
	hyprpolkitagent.service
)
if ! systemctl --user enable --now "${user_units[@]}"; then
	echo "Could not enable user services from this session. After you log in, run:"
	echo "  systemctl --user enable --now ${user_units[*]}"
fi

# Arch's nvm package puts the real script in /usr/share/nvm and links it into ~/.nvm.
# shellcheck disable=SC1091
source /usr/share/nvm/init-nvm.sh
nvm install "$NODE_VERSION"
nvm alias default "$NODE_VERSION"

"$ROOT/link.sh"

cat <<EOF

Done.
Log out and back in so the docker group applies.
On tty1, with no display manager, ~/.bash_profile starts Hyprland.
Open nvim once so it can download plugins and Mason tools.
EOF
