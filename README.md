# dotfiles

My personal dotfiles. Use them at your own risk.

## Dependencies

### Git submodules (downloaded on repository clone)

* [dotbot] for dotfile management

### Binaries

#### apt

* [bat] (installed via .deb to have the latest version)

#### GitHub

* [fetch-master 6000]
* [bat-extras]

#### rust

* [bottom]
* [delta]
* [exa]
* [starship]
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
[bat]: https://github.com/sharkdp/bat
[fetch-master 6000]: https://github.com/anhsirk0/fetch-master-6000
[bat-extras]: https://github.com/eth-p/bat-extras
[bottom]: https://github.com/ClementTsang/bottom
[delta]: https://dandavison.github.io/delta/introduction.html
[exa]: https://github.com/ogham/exa
[starship]: https://starship.rs/
[tokei]: https://github.com/XAMPPRocky/tokei
