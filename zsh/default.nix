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
        rev = "957e07101a1c14502d32a25d9fd327c83098bf3c";
        # date = 2020-01-07T23:52:01+07:00;
        sha256 = "0dmr0b4x903r28w74b8w0vdgmlckhi9n31k26ld24hh2s74g57bk";
      };
     }
    ];
}
