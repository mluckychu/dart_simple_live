#!/bin/bash

# GitHub Actions 自动编译设置脚本
# 使用方法: bash setup-github-actions.sh <你的GitHub用户名>

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查参数
if [ -z "$1" ]; then
    echo "使用方法: bash setup-github-actions.sh <你的GitHub用户名>"
    echo ""
    echo "示例: bash setup-github-actions.sh yourusername"
    exit 1
fi

GITHUB_USERNAME=$1
REPO_NAME="dart_simple_live"

print_info "开始设置GitHub Actions自动编译..."
print_info "GitHub用户名: $GITHUB_USERNAME"

# 检查是否在正确的仓库中
if [ ! -d ".git" ]; then
    print_error "当前目录不是Git仓库!"
    exit 1
fi

print_info "检查当前Git远程仓库..."
CURRENT_REMOTE=$(git remote get-url origin 2>/dev/null || echo "")

if [[ $CURRENT_REMOTE != *"xiaoyaocz"* ]]; then
    print_warn "当前仓库不是原仓库,可能已经Fork过了"
    read -p "是否继续? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

print_info "添加你的Fork作为远程仓库..."
FORK_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# 检查是否已经添加了fork
if git remote get-url fork > /dev/null 2>&1; then
    print_info "Fork远程仓库已存在,更新URL..."
    git remote set-url fork "$FORK_URL"
else
    print_info "添加fork远程仓库..."
    git remote add fork "$FORK_URL"
fi

print_info "GitHub Actions配置文件:"
print_info "  - .github/workflows/build-tv-app.yml (自动编译工作流)"
print_info "  - GITHUB_ACTIONS_GUIDE.md (使用指南)"

print_info "准备推送文件到你的Fork..."
git add .github/workflows/build-tv-app.yml
git add GITHUB_ACTIONS_GUIDE.md
git add simple_live_tv_app/android/gradle-ci.properties

print_info "提交更改..."
git commit -m "feat: 添加GitHub Actions自动编译配置" || {
    print_warn "没有需要提交的更改,可能已经提交过了"
}

print_info "推送到你的Fork仓库..."
git push fork master || {
    print_error "推送失败!请检查:"
    print_error "1. 是否已经Fork了仓库?"
    print_error "2. 你的GitHub用户名是否正确?"
    print_error "3. Fork仓库URL: $FORK_URL"
    echo ""
    echo "请先访问以下链接Fork仓库:"
    echo "https://github.com/xiaoyaocz/dart_simple_live"
    exit 1
}

print_info "✅ 成功推送!"
echo ""
print_info "下一步:"
print_info "1. 访问你的GitHub仓库: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
print_info "2. 点击 'Actions' 标签查看构建状态"
print_info "3. 等待构建完成(通常5-10分钟)"
print_info "4. 构建完成后,从Artifacts或Releases下载APK"
echo ""
print_info "查看详细使用指南: cat GITHUB_ACTIONS_GUIDE.md"
