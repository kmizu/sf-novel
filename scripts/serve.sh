#!/bin/bash

# ========================================
# 《Ω分岐の書庫》開発サーバー起動スクリプト
# ========================================

set -e

# 色付きログ出力用の関数
log_info() {
    echo -e "\033[34m[INFO]\033[0m $1"
}

log_success() {
    echo -e "\033[32m[SUCCESS]\033[0m $1"
}

log_warning() {
    echo -e "\033[33m[WARNING]\033[0m $1"
}

# プロジェクトルートディレクトリに移動
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

log_info "=== 《Ω分岐の書庫》開発サーバー ==="

# 依存関係の確認
if ! command -v mkdocs &> /dev/null; then
    log_warning "MkDocsがインストールされていません。依存関係をインストールします..."
    pip install -r requirements.txt
fi

# ポート番号の設定（デフォルト: 8000）
PORT=${1:-8000}

log_info "開発サーバーを起動中..."
log_info "アクセスURL: http://localhost:$PORT"
log_info "終了するには Ctrl+C を押してください"
echo ""

# MkDocs開発サーバーを起動
mkdocs serve --dev-addr "localhost:$PORT" --livereload