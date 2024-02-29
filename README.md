# NixOS Configuration

My personal [NixOS](https://nixos.org) configuration. This is designed to aid in the development of my
projects, as well let me (relatively) quickly spin up a consistent environment no matter what machine
I use.

This configuration uses both NixOS and flakes, as well as home manager. The NixOS configurations currently
target both a test VM - [alphavm](/hosts/alphavm.nix) - as well as my current admittedly underpowered 
laptop - [epsilon](/hosts/epsilon.nix). 

The current configuration uses KDE Plasma, although I'm definitely going to give other window managers
a go at some point.

Note: This config uses unfree packages, primarily thanks to my laptop having an Nvidia GPU 😔

## How to run

First off, this repo expects you to be running a NixOS instance. Install it or throw it into a VM, easy.

Next, create a directory in your home directory, and clone this repo there. I use `~/.dotfiles` as my main
directory.

Open up `flake.nix` and change the userSettings block to suit what you need, for example, change `username`
to your current Linux user account name. If you don't plan on hosting your config publicaly, then feel free
to also de-obfuscate the email line.

Within the root of your repo, you can then run:

```bash
sudo nixos-rebuild switch --flake .#<host>
```
replacing `<host>` with the name of one of the files in the [/hosts/](/hosts/) directory (excluding suffix), 
for example:

```bash
sudo nixos-rebuild switch --flake .#alphavm
```
will run the configuration designed for a VirtualBox VM. Note that all scripts will set your hostname, and 
after the first run, you can replacce `--flake .#<host>` with just `--flake .`.

Once that completes, next run

```bash
home-manager switch --flake .
```

And you should be up and running!

**Note:** Blender can take an _age_ to compile, at least on my slow laptop and limited VM. Give it time.

## Core Packages

The NixOS config installs - among other things:

* wget
* curl
* git
* git-lfs
* git-credential-manager
* NodeJS 20

My Home Manager config also installs:

* FireFox
* NeoVim
* VSCode FHS
* Godot 4
* Blender 3.6.9 
  * Currently this is primarly there so Godot 4 can use it to import .blend files. This laptop ain't
    gonna be rendering anything any time soon.

It also configures Bash and Git, including setting up git-credential-manager to work correctly with
Azure DevOps. VSCode is there as it's what I have the most expirence with, but I do intend to give
NeoVim a crack.
