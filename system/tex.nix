{config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in {
    environment.systemPackages = with pkgs; [
      # should be interesting to try out the following:
      unstable.python27Packages.pygments
      unstable.biber
      (unstable.texlive.combine {
        inherit (unstable.texlive)
         # classico
         eulervm
         newpx
         kantlipsum
         ly1
         ifxetex
         qtree
         linguex
         libertinus
         libertine
         fontawesome
         tex-gyre
         tex-gyre-math
         bera
         newtx
         inconsolata
         fbb
         cabin
         mweights
         mnsymbol
         gb4e
         expex
         collection-basic
         collection-bibtexextra
         collection-binextra
         # collection-context
         collection-fontsrecommended
         collection-fontutils
         collection-formatsextra
         # collection-plaingeneric
         # collection-genericrecommended
         collection-langenglish
         collection-latex
         collection-latexextra
         collection-latexrecommended
         collection-luatex
         collection-mathscience
         # collection-metapost
         # collection-pictures
         # collection-plainextra
         collection-pstricks
         # collection-science
         collection-xetex;
      })
    ];
}
