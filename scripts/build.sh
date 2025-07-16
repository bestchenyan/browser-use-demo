#!/bin/bash

# Browser-Use Project Build Script

set -e

echo "🚀 Starting build process..."

# 清理旧的构建文件
echo "📦 Cleaning up old build files..."
rm -rf build/ dist/ *.egg-info/

# 创建虚拟环境（如果不存在）
if [ ! -d "venv" ]; then
    echo "🐍 Creating virtual environment..."
    python -m venv venv
fi

# 激活虚拟环境
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# 升级 pip
echo "⬆️ Upgrading pip..."
pip install --upgrade pip

# 安装构建依赖
echo "🔨 Installing build dependencies..."
pip install build twine

# 安装项目依赖
echo "📚 Installing project dependencies..."
pip install -r requirements.txt

# 运行测试（如果存在）
if [ -d "tests" ]; then
    echo "🧪 Running tests..."
    pip install pytest pytest-asyncio
    python -m pytest tests/ -v
fi

# 构建项目
echo "🏗️ Building project..."
python -m build

echo "✅ Build completed successfully!"
echo "📦 Distribution files created in dist/"

# 列出生成的文件
ls -la dist/

echo "🎉 Build process finished!" 