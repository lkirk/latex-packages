put 'export TEXMFHOME=~/.local/share/texmf' in shell startup file (I put it in .zshrc)

Verify latex will pick it up with `kpsewhich -var-value TEXMFHOME`

Run `./install` on every change (latex doesn't like symlinks)
