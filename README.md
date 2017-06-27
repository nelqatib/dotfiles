# dotfiles
:wrench: Yet another dotfiles repo...

## Setup

To use this repository as a start for your configuration files:
```sh
$ git clone http://github.com/marrakchino/dotfiles ~/.dotfiles
$ cd ~/.dotfiles
$ ./setup
# Let the program guide you
```

### One-liner alternative
```sh
$ git clone --recursive http://github.com/marrakchino/dotfiles ~/.dotfiles && sh -c ~/.dotfiles/setup
```

## Contributing

This may not be a collaboration-driven project but any contribution is welcome, especially concerning the `setup` file.
Corrections and typo fixes are encouraged.

# TODO 

* Add a `-A` option to `setup` in order to quickly overwrite all config files without ever being prompted 

* [bash_functions] Create a function to extract a compressed archive whatever compression is used, see https://github.com/techgaun/dotfiles/blob/master/.functions/extract for inspiration

* [bash_functions] Create a function to change directory to the first match from the current directory

* [bashrc] Move bash prompt to a new file: ~/.bash_prompt
