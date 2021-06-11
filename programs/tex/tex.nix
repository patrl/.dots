{ config, pkgs, ... }:

{
  home.packages = with pkgs; [

    pythonPackages.pygments

    (texlive.combine {
      inherit (texlive)
      fontawesome5
      awesomebox
      xcolor-solarized
      luatodonotes
      lm
      # lm-math
      diagbox
      mathabx
      libertinus-fonts
      libertinus-otf
      step
      censor
      firamath
      xits
      ebproof # a more modern package for typesetting prooftrees.
      bussproofs # the classic package for typesetting prooftrees.
      tikz-cd # necessary for commutative diagrams
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
      # ifxetex # FIXME
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
      source = ./biblatex-sp-unified.bbx;
    };
    "texmf/tex/latex/biblatex/sp-authoryear-comp.cbx" = {
      source = ./sp-authoryear-comp.cbx;
    };
  };
}
