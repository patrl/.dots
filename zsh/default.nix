{ pkgs, ... }:

{
  dotDir = ".config/zsh";
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  autocd = true;
  initExtra = ( builtins.readFile ./initExtra.zsh );
  envExtra = ( builtins.readFile ./envExtra.zsh );
  shellAliases = {
    g = "hub";
    git = "hub";
    gcl = "hub clone";
    gstat = "hub status";
    pp = "prettyping";
    l = "exa";
    ls = "exa";
    ll = "exa -l";
    llt = "exa -T";
    llfu = "exa -bghHliS --git";
    prev = ''fzf --preview "bat --color always {}"'';
   };
   plugins = [
     {
     name = "pure";
      src = pkgs.fetchFromGitHub {
        owner = "sindresorhus";
        repo = "pure";
        rev = "v1.11.0";
        sha256 = "0nzvb5iqyn3fv9z5xba850mxphxmnsiq3wxm1rclzffislm8ml1j";
      };
     }
    ];
}
