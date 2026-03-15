#!/bin/bash

# 更新远程仓库为SSH协议

echo "更新远程仓库为SSH协议..."

# 将fork远程仓库更新为SSH
git remote set-url fork git@github.com:mluckychu/dart_simple_live.git

echo "✅ 远程仓库已更新为SSH协议"
echo ""
echo "当前远程仓库配置:"
git remote -v
echo ""
echo "现在可以推送了:"
echo "  git push fork master"
