{ config, pkgs, lib, ... }:

{
  nix.settings = {
    access-tokens = [
      # Store your GitHub token in a secure location like ~/.config/github-token
      # and import it here using environment variables
      "github.com=${builtins.getEnv "GITHUB_TOKEN"}"
    ];
  };
}
