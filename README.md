# 《Ω分岐の書庫》

**The Codex of Branches**

哲学的SF小説 - 全ての選択を知る存在がいたとしたら、私たちの意志に意味はあるのか

[![Build Status](https://github.com/username/omega-codex/workflows/Deploy%20to%20GitHub%20Pages/badge.svg)](https://github.com/username/omega-codex/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)

## 📖 作品について

西暦2347年。人類は地下深くに「全分岐世界記録装置（オメガ・ライブラリ）」を発見する。それは、あらゆる選択の可能性から分岐した全宇宙の記録を保持する構造体であり、そこに存在する観測者＝「Ω（オメガ）」は、過去も未来も、すべての人間がどんな選択を"し得たか"を知っている存在だった。

主人公・ユーリ＝セリグは、Ωライブラリの管理者として招聘される。彼女はある分岐世界の中で、人類が「全能存在＝神」に対して「原罪の逆訴訟」を起こす裁判を準備している事実を発見する。

**罪を犯したのは私たちか？それとも、罪を「犯させた」のは神か？**

### ジャンル
- 哲学的SF / 量子神学スリラー
- テーマ：自由意志 vs 全知、神の責任、原罪の再定義

### 文字数
約10万字（原稿用紙250枚相当）

## 🚀 クイックスタート

### 前提条件
- Python 3.8以上
- Git

### セットアップ

```bash
# リポジトリをクローン
git clone https://github.com/username/omega-codex.git
cd omega-codex

# セットアップスクリプトを実行
./scripts/setup.sh
```

### 開発サーバーの起動

```bash
# ローカルサーバーを起動（デフォルト: localhost:8000）
./scripts/serve.sh

# カスタムポートで起動
./scripts/serve.sh 3000
```

### ビルド

```bash
# 静的サイトをビルド
./scripts/build.sh
```

### デプロイ

```bash
# GitHub Pagesにデプロイ
./scripts/deploy.sh
```

## 📁 プロジェクト構造

```
omega-codex/
├── docs/                    # 小説コンテンツ
│   ├── index.md            # トップページ
│   ├── prologue.md         # プロローグ（3,000字）
│   ├── chapter1/           # 第1章：観測者の資格（18,000字）
│   │   ├── 1-1.md         # 第1節：招聘（3,600字）
│   │   ├── 1-2.md         # 第2節：地下14層への降下（3,600字）
│   │   ├── 1-3.md         # 第3節：最初の観測（3,600字）
│   │   ├── 1-4.md         # 第4節：分岐する私（3,600字）
│   │   └── 1-5.md         # 第5節：観測者の条件（3,600字）
│   ├── chapter2/           # 第2章：断罪される神（18,000字）
│   ├── chapter3/           # 第3章：自由意志の彼岸（20,000字）
│   ├── chapter4/           # 第4章：神の最終弁明（18,000字）
│   ├── chapter5/           # 最終章：選ぶもの／選ばれるもの（20,000字）
│   ├── epilogue.md         # エピローグ（3,000字）
│   ├── appendix/           # 付録
│   │   ├── worldview.md   # 世界観設定
│   │   ├── characters.md  # 登場人物
│   │   └── glossary.md    # 用語集
│   └── about.md           # 作品について
├── scripts/                # ビルドスクリプト
│   ├── setup.sh           # プロジェクトセットアップ
│   ├── build.sh           # サイトビルド
│   ├── serve.sh           # 開発サーバー
│   └── deploy.sh          # GitHub Pagesデプロイ
├── .github/workflows/      # GitHub Actions
│   └── deploy.yml         # 自動デプロイ設定
├── mkdocs.yml             # MkDocs設定
├── pyproject.toml         # Python プロジェクト設定
├── requirements.txt       # 依存関係
└── README.md              # このファイル
```

## 🔧 開発

### 環境設定

```bash
# 仮想環境を作成（推奨）
python3 -m venv omega-codex-env
source omega-codex-env/bin/activate  # Linux/macOS
# omega-codex-env\Scripts\activate   # Windows

# 依存関係をインストール
pip install -r requirements.txt

# 開発用ツールもインストール
pip install -e ".[dev]"
```

### コマンド一覧

| コマンド | 説明 |
|----------|------|
| `./scripts/setup.sh` | プロジェクトの初期セットアップ |
| `./scripts/serve.sh` | 開発サーバーを起動 |
| `./scripts/build.sh` | 静的サイトをビルド |
| `./scripts/deploy.sh` | GitHub Pagesにデプロイ |

### カスタマイズ

#### サイト設定
`mkdocs.yml` でサイトの設定をカスタマイズできます：

- サイト名・説明
- テーマ設定
- ナビゲーション構造
- プラグイン設定

#### スタイル
Material for MkDocsテーマを使用しており、以下をカスタマイズ可能：

- カラーパレット（ライト/ダークモード）
- フォント設定
- 追加CSS（`docs/stylesheets/extra.css`）

## 🌐 デプロイメント

### GitHub Pages（推奨）

1. GitHub でリポジトリを作成
2. ローカルリポジトリとリンク：
   ```bash
   git remote add origin https://github.com/username/omega-codex.git
   ```
3. デプロイ実行：
   ```bash
   ./scripts/deploy.sh
   ```
4. GitHub リポジトリの Settings > Pages で設定確認

### その他のホスティング

- **Netlify**: `site` フォルダをドラッグ&ドロップ
- **Vercel**: GitHub連携で自動デプロイ
- **独自サーバー**: `site` フォルダの内容をアップロード

## 📚 技術仕様

### 使用技術
- **MkDocs**: 静的サイトジェネレータ
- **Material for MkDocs**: レスポンシブテーマ
- **Python**: ビルドツール
- **GitHub Actions**: CI/CD

### ブラウザサポート
- モダンブラウザ（Chrome, Firefox, Safari, Edge）
- モバイル対応
- ダークモード対応

### パフォーマンス
- 静的サイト生成による高速表示
- 画像最適化
- CSS/JS最小化
- PWA対応（オプション）

## 🤝 コントリビューション

### 誤字・脱字の修正
1. 該当ファイルを編集
2. プルリクエストを作成

### 新機能・改善提案
1. Issue を作成して議論
2. フォークしてブランチ作成
3. 変更を実装してプルリクエスト

### 開発ガイドライン
- 各節は3,600〜4,000字を目安に
- マークダウン記法に従う
- モバイル表示を考慮した段落構成

## 📄 ライセンス

このプロジェクトは [MIT License](LICENSE) の下で公開されています。

## 🙏 謝辞

- [MkDocs](https://www.mkdocs.org/) - 優秀な静的サイトジェネレータ
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) - 美しいテーマ
- 量子力学・哲学の研究者の皆様 - インスピレーションの源

## 📞 サポート

- 🐛 バグ報告: [Issues](https://github.com/username/omega-codex/issues)
- 💬 質問・議論: [Discussions](https://github.com/username/omega-codex/discussions)
- 📧 直接連絡: author@example.com

---

*「意志は、神を裁くためにあるのではない。意志は、自らを選び直すためにある。」*

**観測を続ける者へ—あなたもまた、選択している。**