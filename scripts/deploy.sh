#!/bin/bash

# ========================================
# 《Ω分岐の書庫》GitHub Pagesデプロイスクリプト
# ========================================

set -e

# 色付きログ出力用の関数
log_info() {
    echo -e "\033[34m[INFO]\033[0m $1"
}

log_success() {
    echo -e "\033[32m[SUCCESS]\033[0m $1"
}

log_error() {
    echo -e "\033[31m[ERROR]\033[0m $1"
}

log_warning() {
    echo -e "\033[33m[WARNING]\033[0m $1"
}

# プロジェクトルートディレクトリに移動
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

log_info "=== 《Ω分岐の書庫》GitHub Pagesデプロイ ==="

# Gitリポジトリの確認
if [[ ! -d ".git" ]]; then
    log_error "Gitリポジトリが初期化されていません。"
    log_info "以下のコマンドでリポジトリを初期化してください:"
    echo "  git init"
    echo "  git remote add origin <リポジトリURL>"
    exit 1
fi

# リモートリポジトリの確認
if ! git remote get-url origin &> /dev/null; then
    log_error "リモートリポジトリ 'origin' が設定されていません。"
    log_info "以下のコマンドでリモートリポジトリを追加してください:"
    echo "  git remote add origin <リポジトリURL>"
    exit 1
fi

# ワーキングディレクトリの状態確認
if [[ -n "$(git status --porcelain)" ]]; then
    log_warning "ワーキングディレクトリに未コミットの変更があります。"
    echo "変更内容:"
    git status --short
    echo ""
    
    read -p "これらの変更をコミットしてからデプロイしますか？ (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log_info "変更をコミット中..."
        git add .
        git commit -m "📚 Update content before deployment"
    else
        log_info "デプロイを続行します（未コミットの変更は無視されます）"
    fi
fi

# 依存関係のインストール
log_info "依存関係を確認中..."
pip install -r requirements.txt

# MkDocsでGitHub Pagesにデプロイ
log_info "GitHub Pagesにデプロイ中..."
log_warning "注意: これにより gh-pages ブランチが更新されます"

# デプロイ実行
mkdocs gh-deploy --force

log_success "デプロイが完了しました！"
echo ""
log_info "サイトURL（数分後に更新されます）:"

# リモートリポジトリのURLからGitHub PagesのURLを生成
remote_url=$(git remote get-url origin)
if [[ $remote_url =~ github.com[:/]([^/]+)/([^/.]+) ]]; then
    username="${BASH_REMATCH[1]}"
    repo="${BASH_REMATCH[2]}"
    echo "  🌐 https://${username}.github.io/${repo}/"
else
    echo "  🌐 GitHub Pagesの設定を確認してください"
fi

echo ""
log_info "GitHub Pagesの設定確認:"
echo "  1. GitHubリポジトリのSettings > Pagesを開く"
echo "  2. Source: Deploy from a branch"
echo "  3. Branch: gh-pages / (root)"
echo "  4. Save"