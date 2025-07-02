#!/bin/bash

# ========================================
# 《Ω分岐の書庫》プロジェクトセットアップスクリプト
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

log_info "=== 《Ω分岐の書庫》プロジェクトセットアップ ==="

# Pythonバージョンの確認
python_version=$(python3 --version 2>&1 | cut -d' ' -f2 | cut -d'.' -f1,2)
required_version="3.8"

if [[ "$(printf '%s\n' "$required_version" "$python_version" | sort -V | head -n1)" != "$required_version" ]]; then
    log_error "Python $required_version 以上が必要です。現在のバージョン: $python_version"
    exit 1
fi

log_success "Python $python_version を使用します"

# 仮想環境の確認と作成
if [[ -n "$VIRTUAL_ENV" ]]; then
    log_info "既存の仮想環境を使用します: $VIRTUAL_ENV"
else
    log_info "仮想環境が検出されません。"
    
    read -p "新しい仮想環境を作成しますか？ (Y/n): " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        venv_name="omega-codex-env"
        log_info "仮想環境 '$venv_name' を作成中..."
        python3 -m venv "$venv_name"
        
        log_info "仮想環境をアクティベートしてください:"
        echo "  source $venv_name/bin/activate  # Linux/macOS"
        echo "  $venv_name\\Scripts\\activate     # Windows"
        echo ""
        echo "その後、再度このスクリプトを実行してください。"
        exit 0
    fi
fi

# pipのアップグレード
log_info "pipをアップグレード中..."
pip install --upgrade pip

# 依存関係のインストール
log_info "依存関係をインストール中..."
pip install -r requirements.txt

# 開発用依存関係のインストール（オプション）
read -p "開発用ツール（pre-commit, black, flake8など）をインストールしますか？ (y/N): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    log_info "開発用依存関係をインストール中..."
    pip install -e ".[dev]"
    
    # pre-commitの設定
    if command -v pre-commit &> /dev/null; then
        log_info "pre-commitフックを設定中..."
        pre-commit install
    fi
fi

# プロジェクト構造の確認
log_info "プロジェクト構造を確認中..."

required_files=(
    "mkdocs.yml"
    "docs/index.md"
    "docs/prologue.md"
    "docs/epilogue.md"
)

missing_files=()
for file in "${required_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file"
        missing_files+=("$file")
    fi
done

if [[ ${#missing_files[@]} -gt 0 ]]; then
    log_warning "以下のファイルが見つかりません:"
    for file in "${missing_files[@]}"; do
        echo "    - $file"
    done
fi

# ビルドテスト
log_info "ビルドテストを実行中..."
if mkdocs build --quiet; then
    log_success "ビルドテストが成功しました！"
else
    log_error "ビルドテストが失敗しました。設定を確認してください。"
    exit 1
fi

# 実行権限の設定
log_info "スクリプトに実行権限を付与中..."
chmod +x scripts/*.sh

log_success "=== セットアップ完了 ==="
echo ""
log_info "次のステップ:"
echo "  🔧 開発サーバー起動: ./scripts/serve.sh"
echo "  🏗️  サイトビルド:     ./scripts/build.sh"
echo "  🚀 GitHub Pagesデプロイ: ./scripts/deploy.sh"
echo ""
log_info "詳細は README.md を参照してください。"