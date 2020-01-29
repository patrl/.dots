{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true; # software doesn't grow on trees

  home.sessionVariables = {
    # use emacs as my default editor
    EDITOR = "${config.programs.emacs.package}/bin/emacsclient -c";
    VISUAL = "${config.programs.emacs.package}/bin/emacsclient -c";
    # read man pages in neovim (hot!)
    MANPAGER = "${config.programs.neovim.package}/bin/nvim -c 'set ft=man' -";
    NNN_TRASH= "1"; # nnn trashes files to the desktop Trash
    NNN_TMPFILE = "/tmp/nnn";
    NNN_USE_EDITOR= "1";
    PURE_PROMPT_SYMBOL="λ";
    PURE_PROMPT_VICMD_SYMBOL="ν";

  };

  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "/home/patrl/.password-store";
      PASSWORD_STORE_KEY = "patrick.d.elliott@gmail.com";
    };
  };

  programs.browserpass = {
    enable = true;
    browsers = [ "firefox" ];
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
  };

  home.packages = with pkgs; [




    #############
    # nix tools #
    #############

    nix-prefetch-git # update hash in a nix expression; best used through emacs
    nixfmt



    #############
    # cli tools #
    #############

    stow # symlink manager
    gitAndTools.hub # github cli (official). I alias git to this.
    exa # improved ls in rust
    ripgrep # grep with batteries
    prettyping # prettier ping
    age # pgp, but good
    weechat # irc client
    trash-cli # for the rm-happy among us; used by nnn
    nnn # file manager
    unzip # unzipping
    ispell # cli spellcheck; used by emacs
    gtypist
    rclone
    rsync
    magic-wormhole
    ssb-patchwork
    bc # cli calc
    figlet
      neofetch
      file # need this for the nnn plugin nuke
      fd # supercharged find
      imagemagick
      cmus
      asciinema
      pandoc
      haskellPackages.pandoc-citeproc

  ];

  programs.emacs.enable = true;

  programs.neovim = ( import programs/neovim/default.nix { inherit pkgs; });

  programs.bat.enable = true; # a purrfect replacement for cat

  programs.git = ( import programs/git/default.nix { inherit pkgs; }); # git gud

  # avoid derangement via direnv
  programs.direnv = {
    enable = true;
    stdlib = builtins.readFile programs/direnv/direnvrc;
  };

  # junegunn's fuzzy finder
  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f --hidden --follow --exclude .git --exclude .cache/";
    fileWidgetCommand = "${config.programs.fzf.defaultCommand}";
    defaultOptions = [
      "--color=bg+:#44475a,bg:#282a36,spinner:#50fa7b,hl:#44475a"
      "--color=fg:#f8f8f2,header:#ff5555,info:#ff5555,pointer:#50fa7b"
      "--color=marker:#ff5555,fg+:#f8f8f2,prompt:#50fa7b,hl+:#44475a"
    ];
  };

  # ze best shell
  programs.zsh = ( import programs/zsh/default.nix { inherit pkgs; });

  programs.htop.enable = true; # check whether your laptop is melting

  # a spicy hot file manager
  programs.broot.enable = true;

}
