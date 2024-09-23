put 'export TEXMFHOME=~/.local/share/texmf' in shell startup file (I put it in .zshrc)
verify latex will pick it up with `kpsewhich -var-value TEXMFHOME`

mkdir -p ~/.local/share/texmf/tex/latex/local

ln -s {hw,stats} ~/.local/share/texmf/tex/latex/local/


