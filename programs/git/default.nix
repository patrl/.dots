{ pkgs, ... }:

{
  package = pkgs.gitAndTools.git; # FIXME git full seems to be broken
  enable = true;
  userName = "Patrick Elliott";
  userEmail = "patrick.d.elliott@gmail.com";
  signing = {
    signByDefault = true;
    key = "1B5E5824F4429D036C8A17517CA109C3974AF5FA";
  };
  extraConfig = {
    core = {
      pager = "${pkgs.gitAndTools.diff-so-fancy}/bin/diff-so-fancy | less --tabs=4 -RFX";
    };
    rebase = { autostash = "true"; };
    pull = { rebase = "true"; };
    color = { ui = "true"; };
  };
}
