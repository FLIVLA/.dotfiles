#!/bin/bash

SETTINGS_DIR="${HOME}/.dotfiles/.settings"
opts=("Alacritty" "Theme" "Wallpaper" "Waybar" "Other" "Exit")

while true; do

clear
cat <<"EOF"


  ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
  ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
  ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
  ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
  ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
  ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝


EOF

    opt=$(gum choose --limit 1 ${opts[@]})
    case "$opt" in
        "Alacritty")
            "${SETTINGS_DIR}/alacritty.sh"
            ;;
        "Theme")
            "${SETTINGS_DIR}/theme/theme.sh"
            ;;
        "Wallpaper")
            "${SETTINGS_DIR}/wallpaper.sh"
            ;;
        "Waybar")
            "${SETTINGS_DIR}/waybar_settings.sh" 
            ;;
        "Exit")
            break
            ;;
    esac
done
clear

