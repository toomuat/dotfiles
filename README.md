# dotfiles

これは、私の開発環境を構築するための設定ファイルを管理するリポジトリです。
macOS、Ubuntuでのセットアップをサポートします。

## 特徴

*   **クロスプラットフォーム:** macOSとUbuntuの両方に対応したセットアップスクリプト。
*   **ターミナル環境:** Zsh、Tmux、WezTermの設定により、快適なターミナル操作を実現。
*   **高機能エディタ:** Neovim (LazyVim) をベースとしたIDEライクな開発環境。
*   **Git連携:** Gitの基本的な設定と便利なエイリアス。

## 設定ファイル一覧

このリポジトリには、以下のツールの設定ファイルが含まれています。

*   [Zsh](zsh/.zshrc)
*   [Neovim (LazyVim)](nvim/.config/nvim/)
*   [Tmux](tmux/.tmux.conf)
*   [WezTerm](wezterm/.wezterm.lua)
*   [Git](git/.gitconfig)
*   [EditorConfig](.editorconfig)

## インストール

以下のコマンドを実行することで、開発環境のセットアップが開始されます。

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/toomuat/dotfiles/main/install.sh)"
```

## ライセンス

[MIT LICENSE](./LICENCE)
