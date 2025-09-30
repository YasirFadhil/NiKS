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
#fastfetch -c ~/.config/fastfetch/config-compact.jsonc
#pokemon-colorscripts --no-title -s -r

# $env.config.show_banner = false
$env.config = ($env.config | upsert show_banner false)

source ~/.zoxide.nu
source ~/.cache/carapace/init.nu
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

def gup [] {
  let msg = (input "Commit message: ")
  git add .
  git commit -m $msg
  git push -u origin main
}

#alias shortcut
alias ll = clear
alias l = clear
alias sl = ls

#git
alias g = git
alias gad = git add .
alias gcm = git commit -m "."
alias gps = git push -u origin main
alias gcl = git clone

#other
alias cd = z
alias zed = zeditor .
alias nhs = nh os switch /etc/nixos -H nixos
