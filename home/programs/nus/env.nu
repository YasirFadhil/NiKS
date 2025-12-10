# env.nu

zoxide init nushell | save -f ~/.zoxide.nu

$env.PATH | append "/home/kairu/.nix-profile/bin"

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
