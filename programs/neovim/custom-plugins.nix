{ pkgs, ... }:

{
    nnn = pkgs.vimUtils.buildVimPlugin {
      name = "nnn";
      src = pkgs.fetchFromGitHub {
        owner = "mcchrish";
        repo = "nnn.vim";
        rev = "609f577aa468fba560b7fdf004a9e05bdf792659";
        # date = 2020-01-01T09:48:35+05:30;
        sha256 = "1a7nfn4b54y6d66ivr3gxqj0xqj8mv1qkq36xmjgaqwrwk5czl08";
      };
    };

}
