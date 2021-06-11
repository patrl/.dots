self: super:
{
  git-latexdiff = super.git-latexdiff.overrideAttrs ( old: rec {
    version = "1.6.0";
    patches = [];
    postPatch = "";
    src = super.fetchFromGitLab {
      owner = "git-latexdiff";
      repo = "git-latexdiff";
      rev = "70c0b11b58ca368f10babc3f64ee84ceaa7b9924";
      sha256 = "02ak708hwcg1wri6jzr5wcqvch76v5vg1jzg8n5nbl4ir6glcyhw";
      # date = 2020-11-19T11:34:05+01:00;
    };
  });
}
