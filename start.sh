#!/bin/bash

# 配色生成器启动脚本

echo "🎨 启动智能配色生成器..."

# 检查是否有可用的浏览器
if command -v google-chrome &> /dev/null; then
    echo "使用 Google Chrome 打开..."
    google-chrome index.html
elif command -v firefox &> /dev/null; then
    echo "使用 Firefox 打开..."
    firefox index.html
elif command -v chromium-browser &> /dev/null; then
    echo "使用 Chromium 打开..."
    chromium-browser index.html
elif command -v xdg-open &> /dev/null; then
    echo "使用默认浏览器打开..."
    xdg-open index.html
else
    echo "❌ 未找到可用的浏览器"
    echo "请手动在浏览器中打开 index.html 文件"
    echo "或者安装一个浏览器后重试"
    exit 1
fi

echo "✅ 配色生成器已启动！"
echo "💡 提示：按空格键可以快速生成新配色" 