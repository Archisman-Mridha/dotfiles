# Dotfiles

<p>
	<img alt="Zsh" src="https://img.shields.io/badge/Zsh-F15A24?logo=zsh&logoColor=fff&style=for-the-badge" />
	<img alt="Tmux" src="https://img.shields.io/badge/tmux-1BB91F?logo=tmux&logoColor=fff&style=for-the-badge" />
	<img alt="Neovim" src="https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=fff&style=for-the-badge" />
	<img alt="MacOS" src="https://img.shields.io/badge/macOS-000?logo=macos&logoColor=fff&style=for-the-badge" />
	<img alt="Wezterm" src="https://img.shields.io/badge/WezTerm-4E49EE?logo=wezterm&logoColor=fff&style=for-the-badge" />
	<img alt="Linux" src="https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=000&style=for-the-badge" />
	<img alt="Arch Linux" src="https://img.shields.io/badge/Arch%20Linux-1793D1?logo=archlinux&logoColor=fff&style=for-the-badge" />
	<img alt="Hyprland" src="https://img.shields.io/badge/Hyprland-58E1FF?logo=hyprland&logoColor=000&style=for-the-badge" />
</p>

## Installing Arch Linux

You can follow this tutorial : https://www.youtube.com/watch?v=FxeriGuJKTM&t=354s, to install Arch Linux using the Arch Linux Installer. Just make sure you choose `Hyprland` as the desktop environment and `NetworkManager` as the network management tool.

You can list available wifi networks using this command :
```sh
nmcli dev wifi list
```

and connect with one, using this command :
```sh
nmcli dev wifi connect <SSID> password <password>
```

To verify that you're successfully connected to your wifi, run this command :
```sh
ip addr show
```
the `wlan0` network interface must have an IPv4 address assigned.

## Setup

First install Nix :
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Then get into a temporary Nix shell, where you'll have access to git, stow and home-manager.
```sh
nix-shell -p git stow home-manager vim
```

Clone this repository :
```sh
git clone https://github.com/Archisman-Mridha/dotfiles ~/dotfiles
cd ~/dotfiles
```

You can customize [.config/home-manager/config.nix](.config/home-manager/config.nix) based on your
underlying system. Then execute the following commands :
```sh
stow --no-folding .

home-manager switch
```

On MacOS, run the following to install nix-darwin :
```sh
nix run nix-darwin -- switch --flake $(pwd)/.config/home-manager
```

Execute this command, if you want to cleanup Nix cache :
```sh
nix-collect-garbage -d
```

## Arch Linux specific gotchas

- While executing `stow --no-folding .`, in Arch Linux, if you get an error as such :
	```log
		* cannot stow dotfiles/.config/hypr/hyprland.conf over existing target .config/hypr/hyprland.conf since neither a link nor a directory and --adopt not specified
	```
	In that case, first execute `stow --no-folding . --adopt`. Then, navigate to `~/.config/hypr/hyprland.conf` and replace the content with whatever is present [here](./.config/hypr/hyprland.conf).

- If you're in Arch Linux, your default shell will be Bash. And as far as I know, we cannot change the default shell using HomeManager (since that requires root privileges). So, manually execute the following commands, to make zsh your default shell :
	```sh
		grep -qxF $(which zsh) /etc/shells || echo $(which zsh) | sudo tee -a /etc/shells
		chsh -s $(which zsh)
	```

- zsh plugin manager isn't automatically installing `kube-ps1`. So you need to do it yourself :
	```sh
	yay -S kube-ps1
	```

## Updating packages

Go to [./.config/home-manager/](./.config/home-manager/) and run :

```sh
nix flake update
home-manager switch
```

## Cheatsheets

- [Neovim](https://gist.github.com/Archisman-Mridha/41923c35fec46d46497a06bdca56cb6f)
- [Tmux](https://gist.github.com/Archisman-Mridha/d0157da78bac7e1675aa15cfdfa2eb97)
- [iTerm2](https://gist.github.com/Archisman-Mridha/b7654858acb1d7169482f1307b786a67)

## Previews

- Neovim and Tmux
  ![Neovim and Tmux](./previews/neovim-and-tmux.png)

- VSCode
  ![VSCode](./previews/vscode.png)

- Wallpaper
  ![CyberPunk](./.config/wallpapers/cyberpunk.jpg)

## Working in my Arch Linux machine from my Macbook

In your Macbook, open Neovim and run `:DistantInstall`. This will install the distant binary in your machine. Then, run `:DistantLaunch ssh://<username>@<ip or hostname>` to connect to the Arch Linux machine.

> distant.nvim currently doesn't support NeoTree and Telescope integration. But work on them is ongoing. So, as of now, I just SSH into my Arch Linux machine and run Neovim within that SSH session.

## REFERENCES

- [MyNixOS](https://mynixos.com)

- [Appendix A. Home Manager Configuration Options](https://nix-community.github.io/home-manager/options.xhtml)

- [Nix home-manager tutorial: Declare your entire home directory](https://youtu.be/FcC2dzecovw)

- [How I Use Tmux With Neovim For An Awesome Dev Workflow On My Mac](https://www.youtube.com/watch?v=U-omALWIBos)

- [Setup nix, nix-darwin and home-manager from scratch on an M1 Macbook Pro](https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050)

- [When and how should default.nix, shell.nix and release.nix be used?](https://stackoverflow.com/questions/44088192/when-and-how-should-default-nix-shell-nix-and-release-nix-be-used)

- [Master Nix inherit Keyword in 5 Minutes](https://www.ersocon.net/articles/master-nix-inherit-keyword-in-5-minutes~c464b126-0d57-4971-9a87-2515f9aa8d19)

- [Nix Language basics](https://nix.dev/tutorials/nix-language.html)

- [Disabling System Integrity Protection](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection)
- [Determinate Systems : Zero to Nix](https://zero-to-nix.com)

- [Nix darwin activation script by elliott minns](https://gist.github.com/elliottminns/211ef645ebd484eb9a5228570bb60ec3)

- [Installing Arch Linux using the Arch Linux installer](https://www.youtube.com/watch?v=FxeriGuJKTM&t=354s)

- [Arch Linux Experience - Hyprland](https://www.youtube.com/watch?v=uZDPXFQYz0Q)

- [Distant.nvim's Neovim editor guide](https://distant.dev/editors/neovim/)

- [Editing files and running LSP servers on a remote machine](https://youtu.be/BuW2b1Ii0RI?si=vClcQbM75BbJYR73)

## TODOS

- [ ] Detect the underlying OS and CPU architecture, based on which the [macos.config.nix](./.config/home-manager/macos.config.nix) or the [archlinux.config.nix](./.config/home-manager/archlinux.config.nix) will be imported in [flake.nix](./.config/home-manager/flake.nix).

- [ ] Setup gopass.

- [ ] Shift the files inside [.config/home-manager](./.config/home-manager) to [.config/nix](./.config/nix). The [.config/home-manager](./.config/home-manager) name is a bit confusing, since it contains files related to both HomeManager and nix-darwin.

- [ ] Enable image support in Neovim

- [ ] Setup distant.nvim - lualine integration
