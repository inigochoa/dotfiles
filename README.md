# dotfiles

My personal dotfiles. Use them at your own risk.

## Dependencies

### Git submodules (downloaded on repository clone)

* [dotbot] for dotfile management
* [devilbox-cli] for devilbox management

### Binaries

#### apt

* [bat] (installed via .deb to have the latest version)

#### rust

* [bottom]
* [exa]
* [tokei]

## Installing

```bash
git clone --recursive https://github.com/inigochoa/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

## Configuration

Some scripts may require environment variables. To keep them secret, it is
recommended to store them in **shell_local_before** or **bashrc_local_before**

## Update submodules

```bash
./update
```

[dotbot]: https://github.com/anishathalye/dotbot
[devilbox-cli]: https://github.com/inigochoa/devilbox-cli
[bat]: https://github.com/sharkdp/bat
[bottom]: https://github.com/ClementTsang/bottom
[exa]: https://github.com/ogham/exa
[tokei]: https://github.com/XAMPPRocky/tokei
