# Dotfiles

Hyprland, Waybar, Alacritty, and Neovim for a fresh Arch install. The files in this repo are the config. `install.sh` installs the programs, then `link.sh` points `~/.config` at those files.

Ollama and the Neovim plugins that talked to it are not included. Laptop GPU and CPU packages are not installed either. See `packages/hardware.txt`.

## On the new machine

Arch is installed, your user can `sudo`, and the network works. You are logged in as that user, not as root.

```bash
git clone <your-remote-url> ~/dotfiles
cd ~/dotfiles
```

Edit the package lists if you want to add or remove anything. One name per line. Blank lines and lines starting with `#` are skipped.

- `packages/pacman.txt` — desktop and editor
- `packages/dev.txt` — languages, Node, Docker
- `packages/aur.txt` — theme and Cursor
- `packages/optional.txt` and `packages/hardware.txt` are notes. The installer does not read them. Copy a line into one of the three lists above to install it.

Then:

```bash
./install.sh
```

The script upgrades the system, installs the lists, builds `yay` if you don't have it, enables NetworkManager, Bluetooth, and Docker, puts you in the `docker` group, enables the PipeWire and hyprpolkitagent user services, installs the current Node 26 with nvm, and links the configs.

Log out and back in so the Docker group applies. On tty1, with no display manager, `~/.bash_profile` starts Hyprland. Open Neovim once and let it download plugins.

Running `./install.sh` again is safe. Packages already installed are left alone. If a config file is in the way, `link.sh` moves it to `~/.local/state/dotfiles-backup-<date>/` and replaces it with a symlink. Editing `~/.config/nvim` after that edits this repo.

`./link.sh` alone re-links without installing packages.

## Keys

Super is the Hyprland modifier.

| Keys | Action |
| --- | --- |
| Super+Return | Terminal |
| Super+E | Files |
| Super+R | Launcher |
| Super+C | Close window |
| Super+M | Exit Hyprland |
| Super+H/J/K/L | Focus left/down/up/right |
| Super+1..9 | Workspace |
| Super+Shift+1..9 | Move window to workspace |
| Print | Screenshot the output |

## Git credentials

`~/.gitconfig` sets `credential.helper = store`. Git then writes tokens in plaintext to `~/.git-credentials`. Change that line if you want a different helper. No tokens are in this repo.

## Left out

Local models (Ollama, Minuet, CodeCompanion, SearXNG). Cursor's settings and cache (the app is installed, the profile is not). Browsers, GIMP, Kdenlive, VLC, printers, and ClamAV. PostgreSQL, MongoDB tools, gcloud, a JDK, Firefox, and Chrome are listed in `packages/optional.txt` and stay uninstalled until you move a line.
