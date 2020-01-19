{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (texlive.combine {
      inherit (texlive)
      # classico
      babel-german
      bbding
      cleveref
      boondox
      tree-dvips
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

  home.file = {
    "texmf/tex/latex/biblatex/biblatex-sp-unified.bbx" = {
      source = texmf/biblatex-sp-unified.bbx;
    };
    "texmf/tex/latex/biblatex/sp-authoryear-comp.bbx" = {
      source = texmf/biblatex-sp-unified.bbx;
    };
  };
}
