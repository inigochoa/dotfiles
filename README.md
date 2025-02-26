# My Dotfiles Repository 🏠

Welcome to my dotfiles repo! This repository contains all my configuration files
and tools to quickly set up and customize my environment. Everything is managed
with [Dotbot] for a smooth installation process.

## Tools 🛠️

- [atuin]: Modern shell history with search.
- [bat]: A `cat` clone with syntax highlighting.
- [bottom]: A graphical system monitor.
- [dry]: A terminal application to manage and monitor Docker containers.
- [eza]: A modern replacement for `ls`.
- [fastfetch]: A system info fetcher.
- [fzf]: A command-line fuzzy finder.
- [git-cliff]: A customizable changelog generator.
- [git-delta]: A syntax-highlighting pager for git diffs.
- [onefetch]: A tool to display repository information.
- [starship]: A minimal, blazing-fast, and customizable prompt.
- [tealdeer]: A fast implementation of `TLDR`.
- [zoxide]: A smarter way to navigate your filesystem.

## Directory Structure & Files 📁

```shell
.
├── .dotbot/              # dotbot submodule
├── .dotbot-omnipkg/      # omnipkg submodule
├── .dotbot-scripts/      # dotbot shell scripts folder
├── dotfiles/             # dotfiles containing folder
│   ├── bashrc.d/         # modularized bash configuration folder
│   │   ├── bash          # atuin, copy, paste, grep, ...
│   │   ├── directories   # cd, ls, eza, zoxide, ...
│   │   ├── docker        # docker aliases
│   │   ├── files         # bat, confirmations, safeties, ...
│   │   ├── git           # git-cliff, onefetch, ...
│   │   ├── internet      # certificates, pings, ...
│   │   ├── node          # nvm, pnpm, ...
│   │   ├── prompt        # default and starship (if installed)
│   │   └── system        # actions, bottom, screeenFetch, ...
│   ├── config/           # config files and folders
│   │   ├── atuin/
│   │   ├── bat/
│   │   ├── bottom/
│   │   ├── git-cliff/
│   │   ├── tealdeer/
│   │   └── starship.toml
│   ├── bash_logout       # executed when login shell exits
│   ├── bash_profile      # used in login shells
│   ├── bashrc            # default user bashrc file
│   ├── gitconfig         # git aliases
│   └── gitignore_global  # global git ignored files
├── .install.conf.yaml    # dotbot install config
├── install               # dotfiles install script
└── uptade                # repo update script
```

## Installation with Dotbot 🚀

1. **Clone the repository:**

    ```bash
    git clone https://github.com/inigochoa/dotfiles.git
    cd dotfiles
    ```

1. Run Dotbot to install the dotfiles:

    ```bash
    ./install
    ```

## Customization & Usage 🎨

- **Shell Configurations:**

    All Bash configurations are organized in bashrc.d/. Customize each file
    individually to tailor your shell experience.

- **Tool Settings:**

    Tool-specific configuration files are located in the config/ directory.
    Update these as needed to change themes, shortcuts, and other preferences.

- **Git Settings:**

    The gitconfig and gitignore_global files contain your Git settings and
    global ignore rules to maintain a consistent development environment.

## Contributing & Feedback 🤝

If you have suggestions or improvements, feel free to open an issue or submit a
pull request. Let's keep these dotfiles evolving!

[dotbot]: https://github.com/anishathalye/dotbot
[atuin]: https://atuin.sh/
[bat]: https://github.com/sharkdp/bat
[bottom]: https://github.com/ClementTsang/bottom
[dry]: https://moncho.github.io/dry/
[eza]: https://github.com/eza-community/eza
[fastfetch]: https://github.com/fastfetch-cli/fastfetch
[fzf]: https://github.com/junegunn/fzf
[git-cliff]: https://github.com/orhun/git-cliff
[git-delta]: https://github.com/dandavison/delta
[onefetch]: https://onefetch.dev/
[starship]: https://starship.rs/
[tealdeer]: https://github.com/tealdeer-rs/tealdeer
[zoxide]: https://github.com/ajeetdsouza/zoxide
