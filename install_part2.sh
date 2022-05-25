#!/bin/bash

# Detect machine
unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     MACHINE=Linux;;
  Darwin*)    MACHINE=Mac;;
  CYGWIN*)    MACHINE=Cygwin;;
  MINGW*)     MACHINE=MinGw;;
  *)          MACHINE="UNKNOWN:${unameOut}"
esac

echo "Your machine is __"$MACHINE'''__, I used these scripts to install oh-my-zsh, ~/.zshrc configuration, powerlevel10k theme, and other useful packages to the Ubuntu & Kali (Linux) machines on TryHackMe.com, I have not tested the scripts with other machines yet.'''

# Assumes default ZSH installation
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Install additional custom plugins zsh-autosuggestions, k, zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Fix permission
chmod 700 ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Debian dependencies to use the pluggins later
sudo pacman -Sy --noconfirm autojump

# Clone the powerlevel10k repository to oh-my-zsh directory
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Copy Meslo fonts .ttf files into local fonts directory and refresh fonts cache
mkdir -p ~/.local/share/fonts
cp Meslo_Font/*ttf ~/.local/share/fonts
fc-cache -f -v

# Install other useful packages
  #yay
  sudo pacman -Sy --noconfirm yay
  yay -S --noconfirm autojump-git
  yay -S --noconfirm ruby-colorls
  
  
  # tree - list contents of directories in a tree-like format.
  sudo pacman -Sy --noconfirm tree tilix htop neofetch
  # Neofetch - A fast, highly customizable system info script
  #sudo pacman -Sy --noconfirm neofetch
  # htop - interactive process viewer
  #sudo pacman -Sy --noconfirm htop
  # Tilix - Tiling GTK3 terminal emulator for GNOME
  #sudo pacman -Sy --noconfirm tilix
# Replace the OMZ default $HOME/.zshrc file with this .zshrc content
echo '''
# Path to oh-my-zsh installation
export ZSH="/$HOME/.oh-my-zsh"

#Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

#Plugins
plugins=(
    #plugins in $HOME/.oh-my-zsh/plugins/ that can run before zsh-syntax-highlighting
    git sudo web-search dirhistory history jsontools colored-man-pages command-not-found autojump
    #other plugins in $HOME/.oh-my-zsh/custom/plugins/
    zsh-autosuggestions k zsh-syntax-highlighting
    #plugins in $HOME/.oh-my-zsh/plugins/ that can only run after zsh-syntax-highlighting
    history-substring-search
    )
    
source $ZSH/oh-my-zsh.sh

# VTE Configuration for Tilix terminal https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte-2.91.sh
fi
if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls"
    alias la="colorls -al"
fi

''' > $HOME/.zshrc

# Run neofetch to see system information
neofetch

echo '''If you see this line, the installation is successful.
You need to manually change the font in your termianl profile to MesloLGS Regular if you want to use Meslo fonts.
I recommend using "Tilix" terminal emulator, which is already installed above.
Click on Tilix logo upper left corner -> preferences -> default -> custom font -> MesloLGS NF Regular.
If you are already in zsh, please type "source ~/.zshrc" into the terminal or exit & re-open the terminal to see the new zsh customization.
If not, you need to type "zsh" to start Z shell first.'''
