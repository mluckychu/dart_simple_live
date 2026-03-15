#!/bin/bash

# 简单的推送脚本 - 使用Personal Access Token

echo "🚀 推送代码到GitHub"
echo ""
echo "请先获取Personal Access Token:"
echo "1. 访问: https://github.com/settings/tokens"
echo "2. 点击 'Generate new token (classic)'"
echo "3. 勾选 'repo' 权限"
echo "4. 生成并复制token"
echo ""
read -p "请输入Token: " TOKEN

# 使用Token推送
echo ""
echo "📤 正在推送..."
git remote set-url fork https://mluckychu:${TOKEN}@github.com/mluckychu/dart_simple_live.git

if git push fork master; then
    echo ""
    echo "✅ 推送成功!"
    echo ""
    echo "🔗 查看构建状态:"
    echo "   https://github.com/mluckychu/dart_simple_live/actions"
    echo ""
    echo "📥 下载APK:"
    echo "   https://github.com/mluckychu/dart_simple_live/releases"
else
    echo ""
    echo "❌ 推送失败"
    echo "请检查Token是否正确"
fi

# 恢复原始URL(不包含token)
git remote set-url fork https://github.com/mluckychu/dart_simple_live.git
