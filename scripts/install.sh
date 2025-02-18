wget -q https://github.com/axgkl/binenv/releases/download/2025-02-18/binenv_linux_amd64
wget -q https://github.com/axgkl/binenv/releases/download/2025-02-18/checksums.txt
sha256sum --check --ignore-missing checksums.txt
mv binenv_linux_amd64 binenv
chmod +x binenv
./binenv update
./binenv install binenv
rm binenv
if [[ -n $BASH ]]; then ZESHELL=bash; fi
if [[ -n $ZSH_NAME ]]; then ZESHELL=zsh; fi
echo "$ZESHELL"
echo -e '\nexport PATH=~/.binenv:$PATH' >>"$HOME/.${ZESHELL}rc"
echo "source <(binenv completion ${ZESHELL})" >>"$HOME/.${ZESHELL}rc"
exec $SHELL
