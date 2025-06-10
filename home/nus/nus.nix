{ pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    configFile.text = ''
      # Startup commands
      fastfetch -c ~/.config/fastfetch/config-compact.jsonc
      #pokemon-colorscripts --no-title -s -r

      $env.config.show_banner = false

      source ~/.zoxide.nu
      source ~/.cache/carapace/init.nu

      # Custom git commands
      def gup [] {
        let msg = (input "Commit message: ")
        git add .
        git commit -m $msg
        git push origin main
      }

      # Alias shortcut
      alias l = clear
      alias g = git
      alias cd = z
      alias cok = fuck
      alias zed = zeditor

      # Zoxide and Carapace initialization (migrated from env.nu)
      zoxide init nushell | save -f ~/.zoxide.nu
      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
      mkdir ~/.cache/carapace
      carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

      # If you want to modify PATH or other env, use envFile.text or home.sessionPath.
      # Example: $env.PATH | append "/home/kairu/.nix-profile/bin"
    '';
    # Optional: If you want to set environment variables or PATH
    # envFile.text = ''
    #   $env.PATH | append "/home/kairu/.nix-profile/bin"
    # '';
  };
  programs.starship.enable = true;
}
