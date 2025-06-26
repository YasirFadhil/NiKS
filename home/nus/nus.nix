{ pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    configFile.text = ''
      # Startup commands
      fastfetch -c ~/.config/fastfetch/config-compact.jsonc
      #pokemon-colorscripts --no-title -s -r

      $env.config.show_banner = false

      # Initialize zoxide if not already done
      if not ("~/.zoxide.nu" | path expand | path exists) {
        try {
          zoxide init nushell | save -f ~/.zoxide.nu
        } catch {
          print "Warning: Could not initialize zoxide"
        }
      }

      # Initialize carapace if not already done
      if not ("~/.cache/carapace/init.nu" | path expand | path exists) {
        try {
          $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
          mkdir ~/.cache/carapace
          carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
        } catch {
          print "Warning: Could not initialize carapace"
        }
      }

      # Source the files if they exist
      if ("~/.zoxide.nu" | path expand | path exists) {
        source ~/.zoxide.nu
      }
      if ("~/.cache/carapace/init.nu" | path expand | path exists) {
        source ~/.cache/carapace/init.nu
      }

      # Custom git commands
      def gup [] {
        let msg = (input "Commit message: ")
        git add .
        git commit -m $msg
        git push origin main
      }

      # Alias shortcut
      alias nih = sudo nixos-rebuild switch --flake .#nixos
      alias l = clear
      alias sl = ls
      alias g = git
      alias cd = z
      alias cok = fuck
      alias zed = zeditor

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
