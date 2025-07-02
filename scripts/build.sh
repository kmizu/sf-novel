#!/bin/bash

# ========================================
# 《Ω分岐の書庫》ビルドスクリプト
# ========================================

set -e  # エラー発生時にスクリプトを停止

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

log_info "=== 《Ω分岐の書庫》ビルド開始 ==="

# Pythonの仮想環境確認
if [[ -n "$VIRTUAL_ENV" ]]; then
    log_info "仮想環境が有効です: $VIRTUAL_ENV"
else
    log_warning "仮想環境が検出されません。requirements.txtから依存関係をインストールします。"
fi

# 依存関係のインストール
log_info "依存関係をインストール中..."
pip install -r requirements.txt

# mkdocs.ymlの存在確認
if [[ ! -f "mkdocs.yml" ]]; then
    log_error "mkdocs.yml が見つかりません。プロジェクトルートにあることを確認してください。"
    exit 1
fi

# docsディレクトリの存在確認
if [[ ! -d "docs" ]]; then
    log_error "docs ディレクトリが見つかりません。"
    exit 1
fi

# ビルド前のクリーンアップ
if [[ -d "site" ]]; then
    log_info "既存のビルド成果物をクリーンアップ中..."
    rm -rf site
fi

# MkDocsでビルド実行
log_info "MkDocsでサイトをビルド中..."
mkdocs build --strict

# ビルド結果の確認
if [[ -d "site" ]] && [[ -f "site/index.html" ]]; then
    log_success "ビルドが完了しました！"
    log_info "生成されたファイル:"
    
    # 生成されたファイルのサイズ情報を表示
    total_size=$(du -sh site | cut -f1)
    file_count=$(find site -type f | wc -l)
    
    echo "  📁 サイトディレクトリ: ./site"
    echo "  📊 総サイズ: $total_size"
    echo "  📝 ファイル数: $file_count"
    echo ""
    
    # 主要ファイルの存在確認
    log_info "主要ページの確認:"
    pages=(
        "index.html:トップページ"
        "prologue/index.html:プロローグ"
        "chapter1/1-1/index.html:第1章第1節"
        "epilogue/index.html:エピローグ"
    )
    
    for page in "${pages[@]}"; do
        file="${page%%:*}"
        name="${page##*:}"
        if [[ -f "site/$file" ]]; then
            echo "  ✅ $name"
        else
            echo "  ❌ $name (site/$file が見つかりません)"
        fi
    done
    
    echo ""
    log_info "ローカルでプレビューするには:"
    echo "  ./scripts/serve.sh"
    echo ""
    log_info "GitHub Pagesにデプロイするには:"
    echo "  ./scripts/deploy.sh"
    
else
    log_error "ビルドに失敗しました。site ディレクトリまたは index.html が生成されていません。"
    exit 1
fi

log_success "=== ビルド完了 ==="