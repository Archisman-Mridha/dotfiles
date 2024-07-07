## GUIDE

I assume that you've a fresh MacOS installed.

First install Nix :
```sh
sh <(curl -L https://nixos.org/nix/install)
```

Then create a temporary Nix shell, where you'll have access to git, stow and home-manager.
```sh
nix-shell -p git stow home-manager
```

Clone this repository, create symlinks and install packages using home-manager :
```sh
git clone https://github.com/Archisman-Mridha/dotfiles ~/
cd ~/dotfiles
stow --no-folding .

home-manager switch
```

Optionally, you can install the `Monaco Nerd Font` and `Monaco For Powerline` fonts :
```sh
cd ~/Downloads

git clone https://github.com/thep0y/monaco-nerd-font.git
mv ./monaco-nerd-font/ligaturized/* ~/Library/Fonts
rm -rf monaco-nerd-font

wget https://github.com/supermarin/powerline-fonts/raw/master/Monaco/Monaco%20for%20Powerline.otf -P ~/Library/Fonts
```

## CHEATSHEETS

- [Neovim](https://gist.github.com/Archisman-Mridha/41923c35fec46d46497a06bdca56cb6f)
- [Tmux](https://gist.github.com/Archisman-Mridha/d0157da78bac7e1675aa15cfdfa2eb97)
- [iTerm2](https://gist.github.com/Archisman-Mridha/b7654858acb1d7169482f1307b786a67)

## PREVIEWS

- Neovim
![Neovim](./previews/neovim.png)

- VSCode
![VSCode](./previews/vscode.png)

- Zsh Shell + Tmux
![Zsh Shell + Tmux](./previews/tmux.png)

- Desktop
![Desktop](./previews/desktop.png)

## REFERENCES

- [MyNixOS](https://mynixos.com)
- [Nix home-manager tutorial: Declare your entire home directory](https://youtu.be/FcC2dzecovw)
- [How I Use Tmux With Neovim For An Awesome Dev Workflow On My Mac](https://www.youtube.com/watch?v=U-omALWIBos)
