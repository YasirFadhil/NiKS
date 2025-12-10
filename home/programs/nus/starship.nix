{ pkgs, lib, ... }:
let
  accent = "#6cb6eb";
  background-alt = "#282c34";
in {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;

      format = lib.concatStrings [
        # "[$username@$hostname:$directory]($style) "
        "[$username:$directory]($style)"
        "$character"
      ];

      right_format = lib.concatStrings [
        "$git_branch"
        "$git_state"
        "$git_status"
        "$container"
      ];

      container = {
        format = "[$symbol in ($name)]($style) ";
        symbol = "󰆼";
        style = "bold red";
      };

      username = {
        show_always = true;
        style_user = accent;
        style_root = "bold red";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = accent;
        format = "[$hostname]($style)";
      };

      directory = {
        style = accent;
      };

      character = {
        success_symbol = "[❯](${accent})";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](cyan)";
      };

      git_branch = {
        symbol = "[](${background-alt}) ";
        style = "fg:${accent} bg:${background-alt}";
        format = "on [$symbol$branch]($style)[](${background-alt}) ";
      };

      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218)($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "";
        renamed = "";
        deleted = "";
        stashed = "≡";
      };

      git_state = {
        format = "([$state( $progress_current/$progress_total)]($style)) ";
        style = "bright-black";
      };
    };
  };
}
