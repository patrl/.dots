{ pkgs, ... }:

{
  dotDir = ".config/zsh";
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  autocd = true;
  initExtra =
  ''
  export NNN_TRASH=1 # nnn trashes files to the desktop Trash
  export NNN_TMPFILE="/tmp/nnn"
  export NNN_USE_EDITOR=1
  export NNN_OPENER=mimeopen

  export PURE_PROMPT_SYMBOL="λ"
  export PURE_PROMPT_VICMD_SYMBOL="ν"
  '';
  envExtra =
  ''
  path+=('/home/patrl/.emacs.d/bin')

  if [ -e /home/patrl/.nix-profile/etc/profile.d/nix.sh ]; then . /home/patrl/.nix-profile/etc/profile.d/nix.sh; fi
  '';
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
    prev = "fzf --preview \"bat --color always {}\"";
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
