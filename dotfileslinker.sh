#!/bin/bash

DOTFILES_DIR=$(dirname "$(realpath $0)")

check_home_config_files() {
    for config_path in $1/*; do
        home_config_path="$2/$(basename $config_path)"
        if [ -f "$home_config_path" ]; then
            echo "Config file already exists. $(basename $home_config_path) found in $(dirname "$home_config_path")."
            while true; do
                read -n 1 -r -p "Do you want to remove it ? (y/n): " answer
                case "$answer" in
                    [yY])
                        rm $home_config_path
                        break
                        ;;
                    [nN])
                        echo "Won't continue until all config files and directories in home are removed. Aborting."
                        exit 1
                        break
                        ;;
                    *)
                        echo "Invalid input. Please press y or n."
                        ;;
                esac
            done
        fi

        if [ -d "$home_config_path" ]; then
            echo "Config directory already exists. $(basename $home_config_path) found in $(dirname "$home_config_path")."
            while true; do
                read -n 1 -r -p "Do you want to remove it ? (y/n): " answer
                case "$answer" in
                    [yY])
                        rm -r $home_config_path
                        break
                        ;;
                    [nN])
                        echo "Won't continue until all config files and directories in home are removed. Aborting."
                        exit 1
                        break
                        ;;
                    *)
                        echo "Invalid input. Please press y or n."
                        ;;
                esac
            done
        fi
    done
}

make_config_links() {
    dotfiles_config_dir=$DOTFILES_DIR/.config
    if [ ! -e $dotfiles_config_dir ]; then
        echo "Dotfiles .config directory doesn't exist... Aborting."
        exit 1
    fi

    home_config_dir="$HOME/.config"
    check_home_config_files "$dotfiles_config_dir" "$home_config_dir"

    for target_dir in $dotfiles_config_dir/*; do
        source_dir=$home_config_dir/$(basename $target_dir)
        echo "ln -s $target_dir $source_dir"
    done
}

make_scripts_link() {
    dotfiles_scripts_dir="$DOTFILES_DIR/.scripts"
    home_scripts_dir="$HOME/.scripts"

    if [ ! -d "$dotfiles_scripts_dir" ]; then
        echo "Scripts directory not found in dotfiles! Aborting."
        exit 1
    fi

    if [ -d "$home_scripts_dir" ]; then
        echo -n "Scripts directory already found in $home_scripts_dir"
        while true; do
            read -n 1 -r -p "Do you want to remove it ? (y/n): " answer
            case "$answer" in
                [yY])
                    rm -r $home_scripts_dir
                    break
                    ;;
                [nN])
                    echo "Won't continue until scripts directory is removed from home. Aborting."
                    exit 1
                    break
                    ;;
                *)
                    echo "Invalid input. Please press y or n."
                    ;;
            esac
        done
    fi
}

make_wallpapers_link() {
    dotfiles_wallpapers_dir="$DOTFILES_DIR/wallpapers"
    home_wallpapers_dir="$HOME/wallpapers"

    if [ ! -d "$dotfiles_wallpapers_dir" ]; then
        echo "Wallpapers directory not found in dotfiles! Aborting."
        exit 1
    fi

    if [ -d "$home_wallpapers_dir" ]; then
        echo -n "Wallpapers directory already found in $home_wallpapers_dir"
        while true; do
            read -n 1 -r -p "Do you want to remove it ? (y/n): " answer
            case "$answer" in
                [yY])
                    rm -r $home_wallpapers_dir
                    break
                    ;;
                [nN])
                    echo "Won't continue until wallpapers directory is removed from home. Aborting."
                    exit 1
                    break
                    ;;
                *)
                    echo "Invalid input. Please press y or n."
                    ;;
            esac
        done
    fi
}

while true; do
    read -n 1 -r -p "Do you want to link config dotfiles ? (y/n): " answer
    case "$answer" in
        [yY])
            make_config_links
            break
            ;;
        [nN])
            echo "Config dotfiles will not be linked."
            break
            ;;
        *)
            echo "Invalid input. Please press y or n."
            ;;
    esac
done

while true; do
    read -n 1 -r -p "Do you want to link scripts dir from dotfiles ? (y/n): " answer
    case "$answer" in
        [yY])
            make_scripts_link
            break
            ;;
        [nN])
            echo "Scripts directory will not linked."
            break
            ;;
        *)
            echo "Invalid input. Please press y or n."
            ;;
    esac
done

while true; do
    read -n 1 -r -p "Do you want to link wallpapers dir from dotfiles ? (y/n): " answer
    case "$answer" in
        [yY])
            make_wallpapers_link
            break
            ;;
        [nN])
            echo "Wallpapers directory will not linked."
            break
            ;;
        *)
            echo "Invalid input. Please press y or n."
            ;;
    esac
done
