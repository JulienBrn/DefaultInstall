# Vocabulary

- *open app* means to open/execute the app, usually by pressing HOME/WINDOWS Key and searching for *app*
- command lines (code) are meant to be written in a terminal. To open a terminal, either *open terminal* or press Ctrl + Alt + T


# Install Ubuntu

## Make a bootable USB Drive from a Ubuntu computer (or simply ask me for one)

1. Download the [latest stable Ubuntu Desktop](https://ubuntu.com/download/desktop)
2. Have an __empty__ USB Stick 
3. Open *Startup Disk Creator* (if not on Ubuntu, find an equivalent)
4. Fill in the fields as follows and press *Make Startup Disk*
     - Source disc image: the .iso file you just downloaded
     - Disk to use: your USB stick

## Booting on that drive

1. Make sure to press F2 or F12 during startup and select your USB Stick as boot device
2. Select *Try or Install Ubuntu*
3. Select *Try Ubuntu* (do not install yet)
4. Try as much as you want

## Creating space to install Ubuntu

1. Open *Disks* from the ubuntu you are trying
2. Make a partition for where you want to install Ubuntu

## Installing Ubuntu

1. Press the *Install Ubuntu* Icon on the top-right
2. Go through the questions, selecting your choice for the question you know how to answer, making sure to select the correct partition and leaving the defaults for the other questions.

# Setup a basic configuration

Open a terminal either by pressing Ctrl + Alt + T or by pressing Home/Windows key and searching for terminal.

## Install git

Installing git allows you to fetch repositories from github and is thus the start of our installation process

```sh
sudo apt install git
```

## Creating basic folder structure for installations

We suggest you put all installation material in an *CustomSetupMaterial* folder in your home directory. To do so:

```sh
cd ~ #Goes to your home directory
mkdir CustomSetupMaterial #Creates Installs folder
cd CustomSetupMaterial #Goes inside it
```

## Downloading this repo

Once you are in CustomSetupMaterial (last command of last step) simply execute:

`git clone "https://github.com/JulienBrn/DefaultInstall.git"`

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


