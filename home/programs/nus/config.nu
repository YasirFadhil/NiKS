# config.nu

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
