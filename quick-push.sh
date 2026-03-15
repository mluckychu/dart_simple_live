#!/bin/bash

echo "🚀 推送修复到GitHub"
echo ""

read -p "请输入你的GitHub Token: " TOKEN

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
    echo "📥 等待构建完成后下载APK:"
    echo "   https://github.com/mluckychu/dart_simple_live/releases"
    echo ""
else
    echo ""
    echo "❌ 推送失败,请检查Token是否正确"
fi

# 恢复URL
git remote set-url fork https://github.com/mluckychu/dart_simple_live.git
