# Anything needed outside the nvim file system

Following along with a few tweaks ChrisAtMachine's [Nvim from Scratch Series](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)

## Installing Language servers

- [List of language servers managed by nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer/#available-lsps)

- in nvim: `:LspInstall <server>`

### Typical Servers I Install

- `clangd`
- `tsserver` `npm install -g typescript-language-server typescript`
- `pyright` (`jedi_language_server` is also available) `npm install -g pyright`
- `rust_analyser`

- also install `fzf`

## Brew Installs

- `brew install ripgrep` needed for telescope to grep ( get regular expression ) the directory for words in a file. [Repo](https://github.com/BurntSushi/ripgrep#installation)

## Formatters/Linters

- Python

  - Black
  - Flake8

- JS family
  - Prettier
  - ESlint ( installed as part of React )
