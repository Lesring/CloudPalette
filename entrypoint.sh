#!/bin/bash

# Sealos云开发环境启动脚本
# 配色生成器项目

set -e

echo "🎨 启动配色生成器 - Sealos云开发环境"

# 检查环境变量
echo "🔧 环境配置:"
echo "  - NODE_ENV: ${NODE_ENV:-development}"
echo "  - PORT: ${PORT:-3000}"
echo "  - PWD: $(pwd)"

# 安装依赖（如果需要）
if [ ! -d "node_modules" ]; then
    echo "📦 安装Node.js依赖..."
    npm install
fi

# 根据环境启动不同的服务
if [ "$NODE_ENV" = "production" ]; then
    echo "🚀 启动生产环境服务..."
    npm start
else
    echo "🔧 启动开发环境服务..."
    npm run dev
fi
