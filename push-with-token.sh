#!/bin/bash

# 使用Personal Access Token推送代码

echo "📝 使用Personal Access Token推送代码"
echo ""
echo "如果你还没有Token,请先按以下步骤创建:"
echo "1. 访问: https://github.com/settings/tokens"
echo "2. 点击 'Generate new token' → 'Generate new token (classic)'"
echo "3. 勾选 'repo' 权限并生成"
echo "4. 复制生成的token"
echo ""
read -p "请输入你的GitHub Token(输入后不会显示): " -s GITHUB_TOKEN
echo ""
echo ""

# 切换回HTTPS协议
echo "🔄 切换远程仓库为HTTPS..."
git remote set-url fork https://github.com/mluckychu/dart_simple_live.git

# 检查是否有需要提交的内容
if [ -n "$(git status --porcelain)" ]; then
    echo "📦 发现未提交的更改,正在提交..."
    git add -A
    git commit -m "feat: 添加GitHub Actions自动编译配置"
else
    echo "✅ 所有更改已提交"
fi

# 使用Token推送
echo "📤 正在推送到GitHub..."
echo "https://mluckychu:YOUR_TOKEN@github.com/mluckychu/dart_simple_live.git"
echo ""

# 使用Token推送(避免在命令行中暴露token)
GIT_ASKPASS=git-askpass-helper.sh git push fork master 2>&1 || {
    echo ""
    echo "❌ 推送失败,尝试使用URL中的Token方式..."
    echo ""
    read -p "请再次输入Token用于推送: " -s TOKEN
    echo ""
    
    # 替换URL中的token
    REPO_URL="https://mluckychu:${TOKEN}@github.com/mluckychu/dart_simple_live.git"
    git push "$REPO_URL" master
    
    # 恢复原始URL
    git remote set-url fork https://github.com/mluckychu/dart_simple_live.git
}

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 推送成功!"
    echo ""
    echo "📊 查看构建状态:"
    echo "   https://github.com/mluckychu/dart_simple_live/actions"
    echo ""
else
    echo ""
    echo "❌ 推送失败,请检查:"
    echo "   1. Token是否正确"
    echo "   2. Token是否有repo权限"
    echo "   3. 网络连接是否正常"
fi
