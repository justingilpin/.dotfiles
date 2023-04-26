<!-- Rxyhn's yuki -->
<!-- https://github.com/rxyhn/yuki -->

<p align="center">
<a href="https://github.com/nixos/nixpkgs"><img src="https://img.shields.io/badge/NixOS-unstable-informational.svg?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8AADF4"></a>
<a href="https://github.com/justin/.dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=flat&label=License&message=MIT&logoColor=CAD3F5&colorA=24273A&colorB=8AADF4"/></a>
</p>

<p align="center">
<a href="https://github.com/justingilpin/.dotfiles/actions/workflows/check.yml"><img src="https://github.com/rxyhn/yuki/actions/workflows/check.yml/badge.svg"></a> <a href="https://github.com/justingilpin/.dotfiles/actions/workflows/fmt.yml"><img src="https://github.com/justingilpin/.dotfiles/actions/workflows/fmt.yml/badge.svg"/></a>
</p>

<p align="center">
<a href="https://github.com/justin/.dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=flat&label=License&message=MIT&logoColor=CAD3F5&colorA=24273A&colorB=8AADF4"/></a>
</p>
<div align="justify">
<div align="left">

# ❄️ NixOS dotfiles

*My configuration files for NixOS. Feel free to look around and copy!* 
*I'm just a learning NixOS user and far from being an expert*

# Special thanks to:
- [Jhiker98 dotfiles](https://github.com/jhilker98/nixos-dots) Qtile stuff
- [Notusknot's dotfiles](https://github.com/notusknot/dotfiles-nix/tree/main) Hyprland stuff
- [Fufexan's dotfiles](https://github.com/fufexan/dotfiles/tree/main) Flake stuff
- [Rxyhn's dotfiles](https://github.com/rxyhn/yuki) 

## Info
- RAM usage on startup:
- Terminal emulator: alacritty
- Window manager: Qtile or Hyprland
- Shell: 
- Editor: neovim
- Browser: Brave
- Other: dunst, eww, wofi

## Commands to know

- Connect to wifi (used for minimal NixOS iso)
```
iwctl --passphrase [passphrase] station [device] connect [SSID]
```

## Installation

Prerequisites:
- [NixOS installed and running](https://nixos.org/manual/nixos/stable/)
- [Flakes enabled](https://nixos.wiki/wiki/flakes)

** IMPORTANT: Don't use the lenovo/hardware-configuration.nix   **

Generate your own hardware-configuration or copy from a running NixOS at /etc/nixos 

```bash
sudo nixos-generate-config
```

First, create a hardware configuration for your system:

You can then copy this to a the `hosts/` directory (note: change `yourComputer` with whatever you want):

```
mkdir hosts/yourComputer
cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/hosts/yourComputer/
```

Rebuild and switch the system configuration

```bash
sudo nixos-rebuild switch --flake .#yourComputer
```

## Conclusion
And thats about it for my configuration. The code is registered under the MIT license, meaning you are allowed to use or distribute the code as you please.
