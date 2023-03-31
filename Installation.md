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

# Setup system configuration

Open a terminal either by pressing Ctrl + Alt + T or by pressing Home/Windows key and searching for terminal.

## Install git and htop

Installing git allows you to fetch repositories from github and is thus the start of our installation process. 
htop is a simple command to show CPU/Memory usage in terminal.

```sh
sudo apt install git
sudo apt install htop
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

## Configure side-bar

You can play with the preferences settings of the GUI or simply run

```sh
dconf load / < ~/CustomSetupMaterial/DefaultInstall/side_bar.dconf 
```


## Install Guake (Terminal configuration)

### Basic guake install

[Guake](https://github.com/Guake/guake) is a drop-down terminal that is simple to use with many features.

```sh
sudo apt install guake
```

### Configure guake

This step configures Guake with good default behavior. Mainly it binds F12 to toggling, defines Ctrl + | or Ctrl + - for splitting terminals, ...
The easiest way is simply to run the following command and can be done through the graphical interface with *settings -> keyboard -> view and customize shortcuts -> custom shortcuts* (for F12 binding to command `guake -t`) and opening *Guake Preferences* and configure shortcuts.

```sh
dconf load / < ~/CustomSetupMaterial/DefaultInstall/guake_settings.dconf
```

### Run Guake 

#### Run Guake now

Run Guake now by pressing `Alt + F2` and typing `guake`

#### Set Guake as start-up application

Simply run 

```sh
cp ~/CustomSetupMaterial/DefaultInstall/guake_autostart.txt ~/.config/autostart/guake.desktop
```
__OR__

Open *startup application manager*. Press Add and fill the following fields:

- name: *Guake* (or whatever you want)
- Command: `guake`
- Comment: *Starts Guake terminal at startup* (or whatever you want)

## Setup low memory warning script

This is a simple script that warns you when the memory is low allowing you to act before the computer becomes slow.

Simply run 

```sh
cp ~/CustomSetupMaterial/DefaultInstall/memory_autostart.txt ~/.config/autostart/memory.desktop
sed "s;~;$HOME" ~/.config/autostart/memory.desktop
```
__OR__

Open *startup application manager*. Press Add and fill the following fields:

- name: *Memory Warning* (or whatever you want)
- Command: `/home/user/CustomSetupMaterial/DefaultInstall/low_memory_warning.sh` where you replace user by your current user name.
- Comment: *Warns on low memory* (or whatever you want)


# Setup Email Configuration

# Setup Firefox Configuration

The suggestion is simply to use a good existing profile. Documentation on how to do that to come.

# Setup Programming Environment


