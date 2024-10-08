#!/bin/bash

# =============================================================================
# ------------------------- dotfiles install script ---------------------------
# =============================================================================
#
#   1. Variables ........................................................... 16
#   2. Helper Functions .................................................... 28
#   3. Window Manager ...................................................... 51
#   4. AUR Helper ......................................................... 179
#   5. Terminal Emulator .................................................. 221
#   6. Developement Tools .................................................. 44
#   7. dev_tools ............................................................ 
#   8. setup_firewall ..................................................... 543
#   9. Main ............................................................... 589
#
# =============================================================================

# =============================================================================
# ------------------------------- Variables -----------------------------------
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NONE='\033[0m'
CONFIG="${HOME}/.config"
DOTFILES="${HOME}/.dotfiles"
INSTALL_LOG="${HOME}/.dotfiles/.install/install.log"
AUR_HELPER="yay"

# =============================================================================
# ----------------------------- Helper Functions ------------------------------
# =============================================================================

function is_installed() {
    pacman -Qi "$1" &> /dev/null
    return $?
}

function install_package() {
    if is_installed "$1"; then
        echo -e "|-${RED}${BOLD}> ${BLUE}${BOLD}${1}${NONE} is already installed"
    else
        echo -e "|-${BLUE}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}${1}${NONE}..."
        sudo pacman -S --noconfirm "$1" &>> $INSTALL_LOG
        echo -e "|-${CYAN}${BOLD}> ${NONE}Successfully installed ${BLUE}${BOLD}${1}${NONE}"
    fi
}

function mk_directories() {
    mkdir "${HOME}/Documents" "${HOME}/Downloads" "${HOME}/Pictures"
    mkdir -p "${HOME}/Source/repos" "${HOME}/Source/aur"
}

# =============================================================================
# ------------------------------- Window Manager ------------------------------
# =============================================================================

function window_manager() {
    echo 
    echo -e "${CYAN}${BOLD}> ${BLUE}${BOLD}Window Manager${NONE}"
    echo "|"
    echo -e "|-${YELLOW}${BOLD}> ${BLUE}Available Options:${NONE}"
    echo -e "|--${CYAN}${BOLD} 1. ${GREEN}Hyprland${NONE}"
    echo -e "|--${CYAN}${BOLD} 2. ${GREEN}bspwm${NONE}"
    echo "|"
    read -p "|--? Choose a window manager: " choice
    echo "|"
    case "$choice" in
        1)
            local hyprpkgs=(
                "hyprland"    \
                "hyprlock"    \ 
                "waybar"      \ 
                "wofi"        \
                "sddm"        \
            )
            echo -e "|-${CYAN}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}hyprland${NONE}"
            for pkg in "${hyprpkgs[@]}"; do
                install_package "$pkg"
            done

            if [[ -d "${CONFIG}/hypr" ]]; then
                echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}hypr${NONE} configuration"
                mv "${CONFIG}/hypr" "${DOTFILES}/.backup/hypr"
            fi

            mkdir "${CONFIG}/hypr"

            ln -s "${DOTFILES}/hypr/.conf/default.conf" "${CONFIG}/hypr/hyprland.conf"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/.conf/default.conf -> ${CYAN}~/.config/hypr/hyprland.conf${NONE}"
            
            ln -s "${DOTFILES}/hypr/hyprlock.conf" "${CONFIG}/hypr/hyprlock.conf"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/hypr/hyprlock.conf -> ${CYAN}~/.config/hypr/hyprlock.conf${NONE}"

            if [[ -d "${CONFIG}/waybar" ]]; then
                echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}waybar${NONE} configuration"
                mv "${CONFIG}/waybar" "${DOTFILES}/.backup/waybar"
            fi

            ln -s "${DOTFILES}/hypr/waybar/themes/theme-1" "${CONFIG}/waybar"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/hypr/waybar/themes/theme-1 -> ${CYAN}~/.config/waybar${NONE}"
            ;;
        2)
            local bspwmpkgs=(
                "bspwm"         \
                "sxhkd"         \
                "polybar"       \
                "rofi"          \
                "picom"         \
                "dunst"         \
                "feh"           \
                "xorg-xinit"    \
                "xorg-server"   \
                "xorg-xrandr"   \
                "xorg-xset"     \
                "xorg-xsetroot" \
                "lightdm"       \
            )

            echo -e "|-${CYAN}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}bspwm${NONE}"
            for pkg in "${bspwmpkgs[@]}"; do
                install_package "$pkg"
            done

            if [[ -d "${CONFIG}/bspwm" ]]; then
                echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}bspwm${NONE} configuration"
                mv "${CONFIG}/bspwm" "${DOTFILES}/.backup/bspwm"
            fi

            ln -s "${DOTFILES}/bspwm" "${CONFIG}/bspwm"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/bspwm -> ${CYAN}~/.config/bspwm${NONE}"

            if [[ -d "${CONFIG}/sxhkd" ]]; then
                echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}sxhkd${NONE} configuration"
                mv "${CONFIG}/sxhkd" "${DOTFILES}/.backup/sxhkd"
            fi

            ln -s "${DOTFILES}/sxhkd" "${CONFIG}/sxhkd"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/sxhkd -> ${CYAN}~/.config/sxhkd${NONE}"

            if [[ -d "${CONFIG}/polybar" ]]; then
                echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}polybar${NONE} configuration"
                mv "${CONFIG}/polybar" "${DOTFILES}/.backup/polybar"
            fi

            ln -s "${DOTFILES}/polybar" "${CONFIG}/polybar"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/polybar -> ${CYAN}~/.config/polybar${NONE}"

            if [[ -f "${HOME}/.Xresources" ]]; then
                echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}.Xresources${NONE}"
                mv "${HOME}/.Xresources" "${DOTFILES}/.backup/.Xresources"
            fi

            ln -s "${DOTFILES}/.Xresources" "${HOME}/.Xresources"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/.Xresources -> ${CYAN}~/.Xresources${NONE}"
            
            if [[ -d "${DOTFILES}/picom" ]]; then
                echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}picom${NONE} configuration"
                mv "${DOTFILES}/picom" "${DOTFILES}/.backup/picom"
            fi

            ln -s "${DOTFILES}/picom" "${CONFIG}/picom"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/picom -> ${CYAN}~/.config/picom${NONE}"
            ;;
        *)
            echo -e "|-${RED}${BOLD}> ${NONE}Invalid option"
            window_manager
            ;;
    esac
}

# =============================================================================
# --------------------------------- AUR-Helper  -------------------------------
# =============================================================================

function aur_helper() {
    echo
    echo -e "${CYAN}${BOLD}> ${BLUE}${BOLD}AUR Helper${NONE}"
    echo "|"
    echo -e "|-${YELLOW}${BOLD}> ${BLUE}Available Options:${NONE}"
    echo -e "|--${CYAN}${BOLD} 1. ${GREEN}yay${NONE}"
    echo -e "|--${CYAN}${BOLD} 2. ${GREEN}paru${NONE}"
    echo "|"
    read -p "|--? Choose an AUR helper: " choice
    echo "|"
    sudo pacman -S --needed base-devel --noconfirm &>> $INSTALL_LOG
    cd "${HOME}/Source/aur"
    case "$choice" in
        1)
            AUR_HELPER="yay"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Cloning ${BLUE}${BOLD}yay${NONE}"
            git clone https://aur.archlinux.org/yay.git &>> $INSTALL_LOG
            echo -e "|-${CYAN}${BOLD}> ${NONE}Building ${BLUE}${BOLD}yay${NONE} package"
            cd yay && makepkg -si &>> $INSTALL_LOG
            ;;
        2)
            AUR_HELPER="paru"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Cloning ${BLUE}${BOLD}paru${NONE}"
            git clone https://aur.archlinux.org/paru.git &>> $INSTALL_LOG
            echo -e "|-${CYAN}${BOLD}> ${NONE}Building ${BLUE}${BOLD}paru${NONE} package"
            cd paru && makepkg -si &>> $INSTALL_LOG
            ;;
        *)
            echo -e "|-${RED}${BOLD}> ${NONE}Invalid option"
            aur_helper
            ;;
    esac
    cd "${HOME}"
}

# =============================================================================
# ------------------------------- Terminal ------------------------------------
# =============================================================================

# Optional terminal emulator(s) installation:
# - alacritty
# - kitty
#
# Installs a nerd font (FiraCode) for the terminal.
# Installs starship prompt.
#
#

function terminal_emulator() {
    echo
    echo -e "${CYAN}${BOLD}> ${BLUE}${BOLD}Terminal Emulator${NONE}"
    echo "|"
    echo -e "|-${YELLOW}${BOLD}> ${BLUE}Available Options:${NONE}"
    echo -e "|--${CYAN}${BOLD} 1. ${GREEN}alacritty${NONE}"
    echo -e "|--${CYAN}${BOLD} 2. ${GREEN}kitty${NONE}"
    echo "|"
    read -p "|--? Choose a terminal emulator: " choice
    echo "|"
    case "$choice" in
        1)
            echo -e "|-${CYAN}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}alacritty${NONE}"
            install_package "alacritty"

            if [[ -d "${CONFIG}/alacritty" ]]; then
                echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}alacritty${NONE} configuration"
                mv "${CONFIG}/alacritty" "${DOTFILES}/.backup/alacritty"
            fi

            ln -s "${DOTFILES}/alacritty" "${CONFIG}/alacritty"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/alacritty -> ${CYAN}~/.config/alacritty${NONE}"
            ;;
        2)
            echo -e "|-${CYAN}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}kitty${NONE}"
            install_package "kitty"

            if [[ -d "${CONFIG}/kitty" ]]; then
                echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}kitty${NONE} configuration"
                mv "${CONFIG}/kitty" "${DOTFILES}/.backup/kitty"
            fi

            ln -s "${DOTFILES}/kitty" "${CONFIG}/kitty"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/kitty -> ${CYAN}~/.config/kitty${NONE}"
            ;;
        *)
            echo -e "|-${RED}${BOLD}> ${NONE}Invalid option"
            terminal_emulator
            ;;
    esac
    
    echo "|"
    cd "${HOME}/.dotfiles/.tmp"
    
    # install firacode nerd font
    echo -e "|-${CYAN}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}FiraCode Nerd Font${NONE}"
    
    curl -L -o "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip" &>> $INSTALL_LOG
    echo -e "|-${CYAN}${BOLD}> ${NONE}Downloaded ${BLUE}${BOLD}FiraCode Nerd Font${NONE}"
    install_package "unzip"
    
    unzip -q FiraCode.zip &>> $INSTALL_LOG
    echo -e "|-${CYAN}${BOLD}> ${NONE}Extracted ${BLUE}${BOLD}FiraCode Nerd Font${NONE}"
    
    sudo mv "FiraCode/*" "/usr/share/fonts" &>> $INSTALL_LOG
    echo -e "|-${CYAN}${BOLD}> ${NONE}Moved ${BLUE}${BOLD}FiraCode Nerd Font${NONE} to /usr/share/fonts"

    # install starship prompt
    echo "|"
    echo -e "|-${CYAN}${BOLD}> ${BLUE}${BOLD}Installing ${BLUE}${BOLD}starship${NONE}"
    curl -sS https://starship.rs/install.sh | sh &>> $INSTALL_LOG
    
    if [[ -f "${CONFIG}/starship.toml" ]]; then
        echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}starship${NONE} configuration"
        mv "${CONFIG}/starship.toml" "${DOTFILES}/.backup/starship.toml"
    fi
    
    ln -s "${DOTFILES}/starship.toml" "${CONFIG}/starship.toml"
    echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/starship.toml -> ${CYAN}~/.config/starship.toml${NONE}"

    local additional_pkgs=(
        "bat"          \
        "eza"          \
        "fzf"          \
        "ripgrep"      \
    )

    echo "|"
    for pkg in "${additional_pkgs[@]}"; do
        install_package "$pkg"
    done

    if [[ -d "${CONFIG}/bat"  ]]; then
        echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}bat${NONE} configuration"
        mv "${CONFIG}/bat" "${DOTFILES}/.backup/bat"
    fi  

    ln -s "${DOTFILES}/bat" "${CONFIG}/bat"
    echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/bat -> ${CYAN}~/.config/bat${NONE}"
}

# =============================================================================
# ------------------------------- File Manager --------------------------------
# =============================================================================

# Optional file manager(s) installation:
# - ranger
# - thunar
#
# 1. ranger
# 2. thunar
# 3. All
#
# Backsup existing ranger configuration if it exists.
# Clones ranger-devicons2 plugin, for glyphs.
# Symlinks ranger configuration to ~/.config/ranger.

function file_manager() {
    echo
    echo -e "${CYAN}${BOLD}> ${BLUE}${BOLD}File Manager${NONE}"
    echo "|"
    echo -e "|-${YELLOW}${BOLD}> ${BLUE}Available Options:${NONE}"
    echo -e "|--${CYAN}${BOLD} 1. ${GREEN}ranger${NONE}"
    echo -e "|--${CYAN}${BOLD} 2. ${GREEN}thunar${NONE}"
    echo -e "|--${CYAN}${BOLD} 3. ${GREEN}All${NONE}"
    echo -e "|--${CYAN}${BOLD} 4. ${GREEN}None${NONE}"
    echo "|"
    read -p "|--? Choose a file manager: " choice
    echo "|"

    case "$choice" in
        1)
            echo -e "|-${CYAN}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}ranger${NONE}"
            install_package "ranger"
            ;;
        2)
            echo -e "|-${CYAN}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}thunar${NONE}"
            install_package "thunar"
            ;;
        3)
            echo -e "|-${CYAN}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}ranger${NONE}"
            install_package "ranger"
            echo "|"
            echo -e "|-${CYAN}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}thunar${NONE}"
            install_package "thunar"
            ;;
        4)
            echo -e "|-${CYAN}${BOLD}> ${NONE}Skipping file manager installation"
            return
            ;;
        *)
            echo -e "|-${RED}${BOLD}> ${NONE}Invalid option"
            file_manager
            ;;
    esac
    
    if [[ -d "${CONFIG}/ranger" ]]; then
        echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}ranger${NONE} configuration"
        mv "${CONFIG}/ranger" "${DOTFILES}/.backup/ranger"
    fi

    ln -s "${DOTFILES}/ranger" "${CONFIG}/ranger"
    echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ~/.dotfiles/ranger -> ${CYAN}~/.config/ranger${NONE}"

    mkdir "${DOTFILES}/ranger/plugins"
    git clone https://github.com/cdump/ranger-devicons2 ~/.config/ranger/plugins/devicons2 &>> $INSTALL_LOG
    echo -e "|-${CYAN}${BOLD}> ${NONE}Cloned ${BLUE}${BOLD}ranger-devicons2${NONE} plugin"
}

# =============================================================================
# ------------------------------- Languages -----------------------------------
# =============================================================================

# Installs language packages:
# - dotnet-sdk
# - dotnet-runtime
# - aspnet-runtime
# - nodejs
# - npm
# - go
# - php
# - julia
# - jdk-openjdk
# - python-pip

function langs() {
    echo
    read -p "Do you want to install a bunch of language packages? (Y/n): " choice
    
    if [[ "$choice" == "n" || "$choice" == "N" ]]; then
        return
    fi

    echo
    echo -e "${CYAN}${BOLD}> ${BLUE}${BOLD}Installing language packages${NONE}"
    echo "|"
    local packages=(
        "dotnet-sdk"      \
        "dotnet-runtime"  \
        "aspnet-runtime"  \
        "nodejs"          \
        "npm"             \
        "go"              \
        "php"             \
        "julia"           \
        "jdk-openjdk"     \
        "python-pip"
    )
    for package in "${packages[@]}"; do
       install_package "$package" 
    done
    
    if [[ ! -d "${HOME}/.venvs" ]]; then
        mkdir "${HOME}/.venvs"
    fi
}

# =============================================================================
# ----------------------------- Development tools -----------------------------
# =============================================================================

# Installs development tools:
# - git
# - github-cli
# - neovim
# - vscode
# - tmux
# - docker (optional)
# - neovim plugins
# - vscode extensions
# - git configuration (optional), requires user input.
# - symlinks for nvim, tmux, and 
# - symlinks pycodestyle (see file for specific supressed warnings for pylsp).
# - logs all operations to the installation log file.

function dev_tools() {
    echo
    echo -e "${CYAN}${BOLD}> ${BLUE}${BOLD}Installing development tools${NONE}"
    echo "|"
    local packages=(
        "git"         \
        "github-cli"  \
        "neovim"      \
        "code"        \
        "tmux"        \
    )
    for package in "${packages[@]}"; do
        install_package "$package"
    done
    echo "|"
    read -p "|--? Do you want to install docker? (Y/n): " choice
    if [[ "${choice}" == "y" || "${choice}" == "Y" ]]; then
        install_package "docker"    
    fi

    # neovim stuff -----------------------------------------------------------

    local nvimpkgs=(
        "mercurial"     \
        "python-pynvim" \
        "luarocks"      \
    )

    sudo npm install -g neovim &>> $INSTALL_LOG
    echo -e "|-${CYAN}${BOLD}> ${NONE}Installed ${BLUE}${BOLD}neovim${NONE} npm package"

    for pkg in "${nvimpkgs[@]}"; do
        install_package "$pkg"
    done

    
    
    # vscode extensions -------------------------------------------------------

    local vscode_extensions=(
        "catppuccin.catppuccin-vsc"       \
        "catppuccin.catppuccin-vsc-icons" \
        "mads-hartmann.bash-ide-vscode"   \
        "buncip.better-toml"              \
        "esbenp.prettier-vscode"          \
        "vscjava.vscode-java-pack"        
    )

    for extension in "${vscode_extensions[@]}"; do
        code --install-extension "$extension" &>> $INSTALL_LOG
        echo -e "|-${CYAN}${BOLD}> ${NONE}Installed vscode extension ${BLUE}${BOLD}${extension}${NONE}"
    done
    
    # symbolic links ----------------------------------------------------------

    echo "|"
    echo -e "|-${CYAN}${BOLD}> ${BLUE}${BOLD}Setting up symlinks${NONE}"

    if [[ -d "${CONFIG}/nvim" ]]; then
        echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}nvim${NONE}"
        mv "${CONFIG}/nvim" "${DOTFILES}/.backup/nvim"
    fi
    ln -s "${DOTFILES}/nvim" "${CONFIG}/nvim"
    echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ${BLUE}${BOLD}nvim${NONE}"

    if [[ -f "${HOME}/.tmux.conf" ]]; then
        echo -e "|-${CYAN}${BOLD}> ${NONE}Backing up existing ${BLUE}${BOLD}tmux${NONE}"
        mv "${HOME}/.tmux.conf" "${DOTFILES}/.backup/tmux.conf"
    fi
    ln -s "${DOTFILES}/tmux.conf" "${HOME}/.tmux.conf"
    echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ${BLUE}${BOLD}tmux${NONE}"

    if [[ ! -f "${CONFIG}/pycodestyle" ]]; then
        ln -s "${DOTFILES}/lsp/pycodestyle" "${CONFIG}/pycodestyle"
        echo -e "|-${CYAN}${BOLD}> ${NONE}Symlinked ${BLUE}${BOLD}pycodestyle${NONE}"
    fi

    # configure git -----------------------------------------------------------
    
    echo "Git Configuration:" &>> $INSTALL_LOG

    echo "|"
    echo -e "|-${CYAN}${BOLD}> ${BLUE}${BOLD}Git Config${NONE}"
    echo "|"
    read -p "|--? Do you want to configure git? (Y/n): " choice
    if [[ "${choice}" == "y" || "${choice}" == "Y" ]]; then
        read -p "|--? Enter your git username: " username
        read -p "|--? Enter your git email: " email
        git config --global user.name "$username" &>> $INSTALL_LOG
        git config --global user.email "$email" &>> $INSTALL_LOG
        echo -e "|-${CYAN}${BOLD}> ${NONE}Successfully configured git"
    fi
}

# =============================================================================
# --------------------------------- Firewall ----------------------------------
# =============================================================================

# Installs ufw and sets up basic rules.
# - limits port 22 - brute force protection.
# - allows ports 80 and 443.
# - sets default rules to deny incoming and allow outgoing (to prevent leaks).
# - enables ufw service.
# - logs all operations to the installation log file.

function setup_firewall() {
    echo
    echo -e "${CYAN}${BOLD}> ${BLUE}${BOLD}Firewall${NONE}"
    echo "|"
    read -p "|--? Do you want to install firewall (ufw)? (Y/n): " choice
    echo "|"
    if [[ "${choice}" == "y" || "${choice}" == "Y" ]]; then
        if is_installed "ufw"; then
            echo -e "|-${RED}${BOLD}> ${BLUE}${BOLD}${ufw}${NONE} is already installed"
        else
            echo -e "|-${BLUE}${BOLD}> ${NONE}Installing ${BLUE}${BOLD}${ufw}${NONE}..."
            sudo pacman -S --noconfirm "ufw" &>> $INSTALL_LOG
            echo -e "|-${CYAN}${BOLD}> ${NONE}Successfully installed ${BLUE}${BOLD}${ufw}${NONE}"
            
            echo -e "|-${CYAN}${BOLD}> ${NONE}Limiting port 22"
            sudo ufw limit 22/tcp &>> $INSTALL_LOG

            echo -e "|-${CYAN}${BOLD}> ${NONE}Allowing ports 80 and 443"
            sudo ufw allow 80/tcp &>> $INSTALL_LOG
            sudo ufw allow 443/tcp &>> $INSTALL_LOG
            
            echo -e "|-${CYAN}${BOLD}> ${NONE}Setting default rules"
            sudo ufw default deny incoming &>> $INSTALL_LOG
            sudo ufw default allow outgoing &>> $INSTALL_LOG
            
            echo -e "|-${CYAN}${BOLD}> ${NONE}Enabling ufw service"
            sudo systemctl enable ufw &>> $INSTALL_LOG
        fi
    else
        echo -e "|-${CYAN}${BOLD}> ${NONE}Skipping firewall installation"
    fi
}

# =============================================================================
# --------------------------------- Main --------------------------------------
# =============================================================================

function install() {
    echo "> Checking internet connection"
    ping -c 1 8.8.8.8 > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "> Internet is connected."
    else
        echo "> No internet connection. Exiting installation..."
        exit 1
    fi

    # prompt for installation process confirmation
    echo "You are about to install the flin dotfiles. Continue at your own risk."
    read -p "Do you want to proceed with installation? (Y/n): " choice

    case "$choice" in
        y|Y )
            touch "${INSTALL_LOG}"
            mkdir "${DOTFILES}/.backup"

            mk_directories
            window_manager
            aur_helper
            terminal_emulator
            file_manager
            langs
            dev_tools
            setup_firewall

            echo
            echo -e "${GREEN}> ${NONE}Installation complete."
            echo
            read -p "Do you want to reboot now? (Y/n): " choice
            case "$choice" in
                y|Y )
                    sudo reboot
                    ;;
                n|N )
                    echo "> Reboot manually to apply changes."
                    exit 0
                    ;;
            esac
            ;;
        n|N )
            echo "> Aborting..."
            exit 1
            ;;
    esac
}

# require sudo privileges

if [ "$EUID" -ne 0 ]; then
    echo "This script requires sudo privileges for some operations."
    sudo -v
fi

echo -e "${GREEN}"
cat <<"EOF"

█▀▀ █░░ █ █▄░█  ░ █▀▄ █▀█ ▀█▀ █▀▀ █ █░░ █▀▀ █▀
█▀░ █▄▄ █ █░▀█  ▄ █▄▀ █▄█ ░█░ █▀░ █ █▄▄ ██▄ ▄█

Arch linux / hyprland WM installation.

EOF

install
