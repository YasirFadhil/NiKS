# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# them for future reference.

#pfetch
fastfetch -c ~/.config/fastfetch/config-compact.jsonc
#pokemon-colorscripts --no-title -s -r

$env.config.show_banner = false

source ~/.zoxide.nu
source ~/.cache/carapace/init.nu

def git-we3 [] {
  let msg = (input "Commit message: ")
  git add .
  git commit -m $msg
  git push -u origin main
}

def git-we3pro [] {
  let msg = (input "Commit message: ")
  git add .
  git commit -m $msg
  git push -u update main
}

def git-we [] {
  let msg = (input "Commit message: ")
  git add .
  git commit -m $msg
  git push -u ori main
}

#alias shortcut
alias l = clear
alias g = git
alias cd = z
alias cok = fuck
alias zed = zeditor
