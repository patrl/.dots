{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    stow
    browserpass
    gitAndTools.diff-so-fancy
    gitAndTools.hub
    exa
    fd
    prettyping
    age
    weechat

    (texlive.combine {
      inherit (texlive)
         collection-basic
         collection-bibtexextra
         collection-binextra
         collection-xetex
         collection-luatex
         collection-latexrecommended
         collection-latexextra
         collection-langenglish
         collection-latex;
      })
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim -c 'set ft=man' -";
  };

programs.broot = {
  enable = true;
};

programs.bash = {
  enable = true;
  profileExtra = builtins.readFile bash/.profile;
  initExtra = builtins.readFile bash/.bashrc;
  shellAliases = {
    g = "hub";
    git = "hub";
    pp = "prettyping";
    ll = "exa -l"; 
    ls = "exa";
    llt = "exa -T";
    llfu = "exa -bghHliS --git";
    prev = "fzf --preview \"bat --color always {}\"";
   };
};

programs.htop.enable = true;

programs.fzf = {
  enable = true;
  defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude .cache/";
  fileWidgetCommand = "${config.programs.fzf.defaultCommand}";
  defaultOptions = [
    "--color=bg+:#44475a,bg:#282a36,spinner:#50fa7b,hl:#44475a"
    "--color=fg:#f8f8f2,header:#ff5555,info:#ff5555,pointer:#50fa7b"
    "--color=marker:#ff5555,fg+:#f8f8f2,prompt:#50fa7b,hl+:#44475a"
    ];
};

programs.password-store = {
  enable = true;
  settings = {
    PASSWORD_STORE_DIR = "/home/patrl/.password-store";
    PASSWORD_STORE_KEY = "patrick.d.elliott@gmail.com";
  };
};

programs.direnv = {
  enable = true;
};

programs.neovim = {
  enable = true;
  extraConfig = builtins.readFile neovim/init.vim;
  plugins = with pkgs.vimPlugins; [
    vim-sensible
    vim-easy-align 
    vim-slash
    vim-airline
    vim-airline-themes
    vim-devicons
    vim-startify
    vim-nix
    supertab
    ultisnips
    vim-snippets
    vim-fugitive
    vim-surround
    nerdtree
    vim-commentary
    goyo
    ];
};

programs.bat.enable = true;

programs.git = {
  package = pkgs.gitAndTools.gitFull;
  enable = true;
  userName = "Patrick Elliott";
  userEmail = "patrick.d.elliott@gmail.com";
  signing = {
    signByDefault = true;
    key = "1B5E5824F4429D036C8A17517CA109C3974AF5FA";
  };
  extraConfig = {
    core = {
      pager = "diff-so-fancy | less --tabs=4 -RFX";
      };
    rebase = { autostash = "true"; };
    pull = { rebase = "true"; };
    color = { ui = "true"; };
    };
};

services.gpg-agent = {
  enable = true;
  pinentryFlavor = null;
  extraConfig = ''
  pinentry-program /home/patrl/repos/pinentry-wsl-ps1/pinentry-wsl-ps1.sh
  '';
};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";

}
