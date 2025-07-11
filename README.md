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

You can follow this tutorial : <https://www.youtube.com/watch?v=FxeriGuJKTM&t=354s>, to install Arch Linux using the Arch Linux Installer. Just make sure you choose `Hyprland` as the desktop environment and `NetworkManager` as the network management tool.

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
nix-shell -p git git-crypt stow home-manager vim
```

Clone this repository :

```sh
git clone https://github.com/Archisman-Mridha/dotfiles ~/dotfiles
cd ~/dotfiles
```

> [!NOTE]
> Wireguard and Aviatrix config files are encrypted using `git-crypt`.
> Import your GPG key and execute `git-crypt unlock` to decrypt the files.

Then execute :

```sh
stow --no-folding .

home-manager switch \
  --flake $HOME/dotfiles/.config/home-manager#archismanmridha@Archismans-MacBook-Air
```

On MacOS, run the following to install nix-darwin :

```sh
nix run nix-darwin -- switch \
  --flake $(pwd)/.config/nix-darwin
```

The packages specified in [packages.nix](./.config/home-manager/modules/home-manager/packages.nix) and [homebrew.nix](./.config/home-manager/modules/nix-darwin/homebrew.nix) will be installed in your system.

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

- Run this, so SSHD starts up automatically on boot :

  ```sh
  sudo systemctl enable sshd
  ```

## Updating packages

Go to [./.config/home-manager/](./.config/home-manager/) and run :

```sh
nix flake update
home-manager switch --impure
```

## Password management using gopass

### Bootstrap

Since, the company I currently work for uses [Password Store](https://www.passwordstore.org), I will be settling with [gopass](https://github.com/gopasspw/gopass) for now. But, if someday I discontinue working with them, I'll might give [sops-nix](https://youtu.be/G5f6GC7SnhU?si=baQEJPWG1dWgIqZQ) a try.

First, generate a GPG key-pair (which never expires), using this command :

```sh
gpg --gen-key
gpg --edit-key <gpg-key-id>
```

Make sure you backup this GPG key-pair somewhere safe. You can view the actual public and private keys using :

```sh
gpg --export --armor <gpg-key-id>
gpg --export-secret-keys --armor <gpg-key-id>
```

Next, initialize the password store using :

```sh
gopass init <gpg-key-id>
```

You can follow this tutorial, to learn further more about gopass : <https://youtu.be/FhwsfH2TpFA?si=ZIo4NmrTHEcgxS_u>.

### Concurrent setups

First, import and trust the GPG keypair :

```sh
gpg --import password-store.private-key.gpg
gpg --import password-store.public-key.gpg

gpg --edit-key <GPG key-pair id> (and then type trust and hit Enter)
```

Then, as usual, initialize the password store using `pass init <GPG key-id>`.

The SSH key-pair I use to sign commits and authenticate against Github, is stored at `personal/github/ssh`. So, I use these commands to complete my Github setup :

```sh
gopass show personal/github/ssh/private-key > ~/.ssh/github
gopass show personal/github/ssh/public-key  > ~/.ssh/github.pub
```

Don't forget to set correct file permission for the private key file :

```sh
chmod 600 ~/.ssh/github.pub
```

otherwise you'll get `file permissions too open` error.

> A small script can be made for a better UX.

## Wezterm (and tmux)

- [Copy Mode](https://wezfurlong.org/wezterm/copymode.html)
- [Quick Select Mode](https://wezfurlong.org/wezterm/quickselect.html)

## Working in my Arch Linux machine from my Macbook

Everytime, I connect to the wifi from my Arch Linux machine, I want it to get assigned with the same private IPv4 address : `192.168.29.146/24`. I can pull it off, using this command :

```sh
sudo nmcli connection modify "Bandwidth 5" \
  ipv4.method manual \
  ipv4.addresses "192.168.29.146/24" \
  ipv4.gateway "192.168.29.1" \
  ipv4.dns "8.8.8.8 8.8.4.4"

sudo nmcli connection up "Bandwidth 5"
```

In my Macbook, I open Neovim and run `:DistantInstall`. This will install the distant binary in my Macbook. Then, I run `:DistantLaunch ssh://<username>@<ip or hostname>` to connect to the Arch Linux machine.

> distant.nvim currently doesn't support NeoTree and Telescope integration. But work on them is ongoing. So, as of now, I just SSH into my Arch Linux machine and run Neovim within that SSH session.

## Cheatsheets

- [Neovim](https://gist.github.com/Archisman-Mridha/41923c35fec46d46497a06bdca56cb6f)
- [Tmux](https://gist.github.com/Archisman-Mridha/d0157da78bac7e1675aa15cfdfa2eb97)
- [iTerm2](https://gist.github.com/Archisman-Mridha/b7654858acb1d7169482f1307b786a67)

## Previews

- Neovim and Tmux
  ![Neovim](./previews/neovim-and-tmux.png)

- Wezterm
  ![Wezterm](./previews/wezterm.png)

- VSCode
  ![VSCode](./previews/vscode.png)

- Wallpaper
  ![Glassy](./.config/wallpapers/glassy.jpg)

## References

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

- [SSH Port Forwarding](https://www.geeksforgeeks.org/ssh-port-forwarding/)

- [This is perhaps my favorite password manager for the terminal](https://youtu.be/FhwsfH2TpFA?si=ZIo4NmrTHEcgxS_u)

- [PASS: a Password Manager & Two Factor Authentication (OTP) with no Cell Phone](https://youtu.be/sVkURNfxPd4?si=CD71pMNqsEzQhaDN)

- [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

- [My Wezterm Config](https://www.youtube.com/watch?v=V1X4WQTaxrc)

- [Is it possible to disable lsp formatting temporarily?](https://www.reddit.com/r/neovim/comments/oo8jcu/is_it_possible_to_disable_lsp_formatting/)

- [How to Use Multiple Git Configs on One Computer](https://www.freecodecamp.org/news/how-to-handle-multiple-git-configurations-in-one-machine/)

- [Seamless copy-paste between tmux, vim and clipboard over ssh](https://gronskiy.com/posts/2023-03-26-copy-via-vim-tmux-ssh/)

## TODOs

- [x] Detect the underlying OS and CPU architecture, based on which the [macos.config.nix](./.config/home-manager/macos.config.nix) or the [archlinux.config.nix](./.config/home-manager/archlinux.config.nix) will be imported in [flake.nix](./.config/home-manager/flake.nix).

- [x] Setup gopass.

- [ ] Configure Hyprland.

- [x] Enable image support in Neovim
