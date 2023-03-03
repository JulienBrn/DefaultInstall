# Start

Open a terminal either by pressing Ctrl + Alt + T or by pressing Home/Windows key and searching for terminal.

# Installing Basic Utility

## Install git

```sh
sudo apt install git
```

## Install zsh (Shell configuration)

### Basic zsh configuration
*Warning*: You may not see the results before rebooting

```sh
sudo apt install zsh   # Installs zsh
chsh -s $(which zsh)   # Sets zsh as default shell
```

### Adding oh-my-zsh configuration

Fetches [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) install file and launches it (thus installing the git repository in `~/.oh-my-zsh` and setting `~/.zshrc` to use it (i.e. use ` source` command on it).

```sh
cd ~
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

## Install Guake (Terminal configuration)

### Basic guake install

[Guake](https://github.com/Guake/guake) is a drop-down terminal that is simple to use with many features.

```sh
sudo apt install guake
```

### Run Guake 

#### Run Guake now

Run Guake now by pressing `Alt + F2` and typing `guake`

#### Set Guake as start-up application

Run the command `gnome-session-properties` to get into the *startup application manager* or press Home/Windows key and search for *startup application*. Press Add and fill the following fields:

- name: *Guake* (or whatever you want)
- Command: `guake`
- Comment: *Starts Guake terminal at startup* (or whatever you want)


### Adding F12 custom shortcut for toggling

 Use one of the following options:
 
- Graphical user interface:
     1. Go to  *settings -> keyboard -> view and customize shortcuts -> custum shortcuts*
     2. Click on *+*
     3. Fill in the fields:
         - name: Choose a name of your choice. Suggestion: "Guake Terminal Toggle" 
         - command: `guake-toggle`
         - shortcut: F12

- Using the following commands:
__WARNING__: This will remove all other custum shortcuts you may have
```sh
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "'Guake Terminal Toggle'"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'F12'"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "'guake-toggle'"
```

__TEST__ all is well by pressing F12 several times to toggle/untoggle


