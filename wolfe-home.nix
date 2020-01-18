{ config, pkgs, ... }:

let
  plugins = pkgs.vimPlugins;
in {
  home.packages = with pkgs; [
    stow
    gitAndTools.diff-so-fancy
    gitAndTools.hub
    exa
    fd
    ripgrep
    prettyping
    age
    weechat
    trash-cli
    nnn

    lxappearance

    nix-prefetch-git

    glxinfo
    dmenu
    sxhkd
    polybar
    pciutils
    xorg.xdpyinfo
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim -c 'set ft=man' -";
  };

programs.broot = {
  enable = true;
};

programs.alacritty.enable = true;

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

programs.firefox = {
  enable = true;
};

nixpkgs.config.allowUnfree = true;

xsession.pointerCursor = {
  name = "Vanilla-DMZ";
  package = pkgs.vanilla-dmz;
  size = 128;
};

programs.zsh = {
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


  if [ -e /home/patrl/.config/broot/launcher/bash/br/1 ]; then . /home/patrl/.config/broot/launcher/bash/br/1; fi
  '';
  shellAliases = {
    g = "hub";
    git = "hub";
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
};

programs.emacs = {
  enable = true;
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



programs.direnv = {
  enable = true;
  stdlib = builtins.readFile direnv/direnv.conf;
};

programs.neovim = {
  enable = true;
  viAlias = true;
  vimAlias = true;
  configure = {
    customRC = builtins.readFile neovim/init.vim;
    plug.plugins = with plugins; [
      # theme
      vim-airline-themes
      vim-sensible
      vim-easy-align 
      vim-slash
      vim-airline
      vim-devicons
      vim-startify
      vim-nix
      seoul256-vim
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

programs.gpg.enable = true;

services.gpg-agent = {
  enable = true;
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

  services.emacs.enable = true;

  services.polybar.enable = true;

  services.polybar.config = polybar/polybar.conf;

  services.polybar.script = ''
  polybar bar &
'';

  services.network-manager-applet.enable = true;

 home.file = {
    ".config/alacritty/alacritty.yml" = {
      source = alacritty/alacritty.yml;
    };
  };

}
