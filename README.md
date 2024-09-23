## Latex Packages

These are a few latex classes I'm developing for various niche document classes
I need (such as homework, conference posters, stats commands).

I regret developing them in LaTeX2e instead of expl3. Alas, one day...

### Installation

put 'export TEXMFHOME=~/.local/share/texmf' in shell startup file (I put it in .zshrc)

Verify latex will pick it up with `kpsewhich -var-value TEXMFHOME`

Run `./install` on every change (latex doesn't like symlinks)

After installation, make sure that latex is seeing the files with:
```bash
kpsewhich hw.cls stats.sty
```
It should print out their locations. It exits 1 if they're not found.

TODO:
get the beamerposter class installed.
version control the compile-loop script.
