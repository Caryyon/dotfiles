# Dotfiles

My personal development environment configuration using the bare git repository method.

## What's Included

- **Neovim** - Full configuration with custom gmork theme and LSP setup
- **Zsh** - Shell configuration with oh-my-zsh and custom gmork theme
- **Tmux** - Terminal multiplexer configuration
- **Alacritty** - GPU-accelerated terminal emulator config
- **Tmuxinator** - Tmux session manager project configs

## Setup on New Machine

### Prerequisites

Install these tools first:
```bash
# Install Homebrew (if on macOS)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install essential tools
brew install git neovim tmux zsh alacritty fzf bat eza lazygit lazydocker

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install tmuxinator
gem install tmuxinator
```

### Clone Dotfiles

```bash
# Clone the dotfiles repo as a bare repository
git clone --bare https://github.com/Caryyon/dotfiles.git $HOME/.dotfiles.git

# Define the dotfiles alias temporarily
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'

# Checkout the actual files
dotfiles checkout

# If the above fails (because files already exist), backup and remove them:
# mkdir -p ~/.dotfiles-backup
# dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} ~/.dotfiles-backup/{}
# dotfiles checkout

# Hide untracked files
dotfiles config --local status.showUntrackedFiles no

# Source your new zshrc (which includes the dotfiles alias)
source ~/.zshrc
```

### Setup Secrets

Create `~/.zshrc.local` with your API keys and secrets:
```bash
# Example ~/.zshrc.local
export OPENAI_API_KEY='your-key-here'
export REPLICATE_API_TOKEN='your-token-here'
# Add other secrets...
```

### Setup Oh-My-Zsh Theme and Plugins

```bash
# Copy gmork theme to oh-my-zsh themes directory
cp ~/.config/zsh/themes/gmork.zsh-theme ~/.oh-my-zsh/themes/

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

### Install Neovim Plugins

Open neovim and let lazy.nvim install all plugins:
```bash
nvim
# Plugins will auto-install on first launch
```

## Usage

Once setup is complete, use the `dotfiles` command instead of `git` for managing your configuration:

```bash
# Check status
dotfiles status

# Add a file
dotfiles add ~/.zshrc

# Commit changes
dotfiles commit -m "update zsh config"

# Push to remote
dotfiles push

# Pull latest changes
dotfiles pull
```

## Important Notes

- **Never commit secrets!** Use `~/.zshrc.local` for API keys and sensitive data
- The `.gitignore` is configured to protect you, but always double-check before pushing
- Only explicitly added files are tracked (untracked files are hidden by default)

## Troubleshooting

### Files conflict on checkout
Backup existing files and try again:
```bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} ~/.dotfiles-backup/{}
dotfiles checkout
```

### Neovim plugins not loading
Try manually syncing plugins:
```bash
nvim
:Lazy sync
```

### Zsh plugins not working
Ensure plugins are cloned and .zshrc is sourced:
```bash
ls ~/.oh-my-zsh/custom/plugins/
source ~/.zshrc
```
