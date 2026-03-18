# Dotfiles

My personal development environment configuration using the bare git repository method. Works on **macOS** and **Linux**.

## What's Included

- **Neovim** - Full configuration with custom gmork theme and LSP setup
- **Zsh** - Shell configuration with oh-my-zsh and custom gmork theme
- **Tmux** - Terminal multiplexer configuration with session persistence
- **Alacritty** - GPU-accelerated terminal emulator config
- **Tmuxinator** - Tmux session manager project configs

## Quick Start (Automated)

The easiest way to get set up on a new machine:

```bash
# Download and run the install script
curl -fsSL https://raw.githubusercontent.com/Caryyon/dotfiles/main/install.sh | bash
```

Or clone first and run locally:

```bash
git clone https://github.com/Caryyon/dotfiles.git /tmp/dotfiles
bash /tmp/dotfiles/install.sh
```

## Manual Setup

### Prerequisites

#### macOS

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install essential tools
brew install git neovim tmux zsh fzf bat eza lazygit ripgrep fd

# Optional GUI apps
brew install --cask alacritty
```

#### Debian/Ubuntu

```bash
sudo apt update
sudo apt install -y git neovim tmux zsh fzf bat ripgrep fd-find curl

# bat and fd have different names on Debian
sudo ln -sf /usr/bin/batcat /usr/local/bin/bat
sudo ln -sf /usr/bin/fdfind /usr/local/bin/fd

# eza (check latest release: https://github.com/eza-community/eza/releases)
# or install via cargo: cargo install eza
```

#### Fedora

```bash
sudo dnf install -y git neovim tmux zsh fzf bat eza ripgrep fd-find
```

#### Arch Linux

```bash
sudo pacman -Syu git neovim tmux zsh fzf bat eza lazygit ripgrep fd
```

### Install oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Clone Dotfiles

```bash
# Clone the dotfiles repo as a bare repository
git clone --bare https://github.com/Caryyon/dotfiles.git $HOME/.dotfiles.git

# Define the dotfiles alias temporarily
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'

# Checkout the actual files
dotfiles checkout

# If the above fails (because files already exist), backup and try again:
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} ~/.dotfiles-backup/{}
dotfiles checkout

# Hide untracked files
dotfiles config --local status.showUntrackedFiles no

# Source your new zshrc (which includes the dotfiles alias)
source ~/.zshrc
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

### Install Tmux Plugin Manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Then in tmux, press prefix + I to install plugins
```

### Install NVM (Node Version Manager)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

### Setup Machine-Specific Config

Create `~/.zshrc.local` for secrets and machine-specific settings (not tracked in git):

```bash
# Example ~/.zshrc.local for PERSONAL machine
export OPENAI_API_KEY='your-key-here'

# Example ~/.zshrc.local for WORK machine (behind corporate proxy)
# 1. Export corporate CA bundle (run once):
#    (security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain && \
#     security find-certificate -a -p /Library/Keychains/System.keychain) > ~/.corporate-ca-bundle.pem
#
# 2. Add these to ~/.zshrc.local:
export NODE_EXTRA_CA_CERTS="$HOME/.corporate-ca-bundle.pem"
export COPILOT_GITHUB_ENTERPRISE_HOST="github.yourcompany.com"
```

### Install Neovim Plugins

Open neovim and let lazy.nvim install all plugins:

```bash
nvim
# Plugins will auto-install on first launch
```

### Setup GitHub Copilot

After plugins install, authenticate Copilot with your GitHub account:

```vim
:Copilot auth
```

This opens a browser for GitHub authentication. Once complete, Copilot suggestions appear in your completion menu.

### Install LSP Servers

LSP servers are auto-installed via Mason. To manually install or update:

```vim
:Mason
# Press i on any server to install
```

## Usage

Use the `dotfiles` command instead of `git` for managing your configuration:

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

## Tool Dependencies

| Tool | Purpose | Install |
|------|---------|---------|
| `neovim` | Editor | Required |
| `tmux` | Terminal multiplexer | Required |
| `zsh` | Shell | Required |
| `fzf` | Fuzzy finder | Required |
| `bat` | Better cat | Recommended |
| `eza` | Better ls | Recommended |
| `lazygit` | Git UI | Recommended |
| `ripgrep` | Fast grep | Recommended |
| `fd` | Fast find | Recommended |
| `lazydocker` | Docker UI | Optional |
| `alacritty` | Terminal emulator | Optional |

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

### Tmux plugins not installing

Make sure TPM is installed, then press `prefix + I` in tmux:

```bash
# Check if TPM exists
ls ~/.tmux/plugins/tpm

# If not, install it
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Clipboard not working

- **macOS**: Should work out of the box
- **Linux X11**: Install `xclip` or `xsel`
- **Linux Wayland**: Install `wl-clipboard`

```bash
# Debian/Ubuntu
sudo apt install xclip  # or wl-clipboard for Wayland

# Fedora
sudo dnf install xclip  # or wl-clipboard for Wayland

# Arch
sudo pacman -S xclip    # or wl-clipboard for Wayland
```

### Copilot "unable to get local issuer certificate" error

This happens on corporate networks with SSL inspection (Zscaler, Netskope, etc.).

**Fix for macOS:**

```bash
# Export all system certificates including corporate CA
(security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain && \
 security find-certificate -a -p /Library/Keychains/System.keychain) > ~/.corporate-ca-bundle.pem

# Add to ~/.zshrc.local
echo 'export NODE_EXTRA_CA_CERTS="$HOME/.corporate-ca-bundle.pem"' >> ~/.zshrc.local
source ~/.zshrc
```

**Fix for Linux:**

```bash
# Point to system CA bundle (should include corporate certs if IT configured them)
echo 'export NODE_EXTRA_CA_CERTS="/etc/ssl/certs/ca-certificates.crt"' >> ~/.zshrc.local
source ~/.zshrc
```

**Nuclear option (if nothing else works):**

```bash
echo 'export NODE_TLS_REJECT_UNAUTHORIZED=0' >> ~/.zshrc.local
```

Then restart nvim and run `:Copilot auth` again.

### Copilot with GitHub Enterprise

For work machines using GitHub Enterprise Copilot:

```bash
# Add to ~/.zshrc.local
export COPILOT_GITHUB_ENTERPRISE_HOST="github.yourcompany.com"
```
