#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Required "sudo""
	exit 1
fi

apt install clangd jq
mkdir -p ~/.local/share/nvim/mason/packages/clangd/mason-schemas
cd ~/.local/share/nvim/mason/packages/clangd
curl https://raw.githubusercontent.com/clangd/vscode-clangd/master/package.json \
    | jq .contributes.configuration > mason-schemas/lsp.json
echo '{"schema_version":"1.1","primary_source":{"type":"local"},"name":"clangd","links":{"share":{"mason-schemas/lsp/clangd.json":"mason-schemas/lsp.json"}}}' \
    > mason-receipt.json
