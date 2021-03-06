#!/usr/bin/env bash

# This script was highly inspired by this repository: https://github.com/fs/dotfiles
# It allows the user to copy the configuration files in this repository to their local
# machine: they can choose to overwrite their local configuration files with the new ones,
# keep them as are, or back them up.

do_link(){
	ln -fs "$1" "$2"
	echo "[SETUP] linking \"$1\" to \"$2\"..."
}

install(){
	echo "[SETUP] installing dotfiles..."
	shopt -s dotglob # needed to iterate over hidden files
	for symlink_file in ~/.dotfiles/*.symlink; do
		echo "[SETUP] installing \"$symlink_file\"..."
		real_file="$HOME/$(basename "${symlink_file%.*}")"
	    
		if [ -f "$real_file" ] || [ -d "$real_file" ] || [ -L "$real_file" ]; then
			overwrite=false
			backup=false
			skip=false

			overwrite_all=false
			backup_all=false
			skip_all=false

			if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

                if [[ "$1" -eq "-A" ]]; then
                    action="A"
                else
                    printf "File \033[00;34m$(basename "$symlink_file")\033[0m already exists, do you want to? "
                    echo "[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
                    read -rn 1 action
                fi

				case "$action" in
					o )
						overwrite=true;;
					O )
						overwrite_all=true;;
					b )
						backup=true;;
					B )
						backup_all=true;;
					s )
						skip=true;;
					S )
						skip_all=true;;
					* )
						;;
				esac
			fi

			if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]; then
				rm -rf "$real_file"
				echo "[SETUP] removed $real_file"
			fi

			if [ "$backup" == "true" ] || [ "$backup_all" == "true" ]; then
				mv "$real_file" "$real_file.backup"
				echo "[SETUP] moved $real_file to $real_file.backup"
			fi

			if [ "$skip" == "false" ] && [ "$skip_all" == "false" ]; then
				do_link "$symlink_file" "$real_file"
			else
				echo "[SETUP] skipped $symlink_file"
			fi

		else
			do_link "$symlink_file" "$real_file"
		fi
	done
}

set -e
echo ''
if [[ "$1" -eq "-A" ]]; then
    install "-A"
    exit $?
fi

# TODO FIXME
if [[ "$#" -eq 1 ]]; then
    # link one file ($1), can be useful to link a new file
    real_file="$1"
    rename -n 's/\.symlink//g' "${real_file}" # real file path may still contain .symlink TODO: this rename doesn't seem to be working...
    echo "symlinking $1 to $real_file"
#     do_link "$1" "$real_file"
else 
    install
fi
