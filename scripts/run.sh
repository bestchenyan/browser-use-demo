#!/bin/bash

# Browser-Use Project Run Script

set -e

# 检查环境变量文件
if [ ! -f ".env" ]; then
    echo "❌ .env file not found!"
    echo "📝 Please copy env.template to .env and configure your settings:"
    echo "   cp env.template .env"
    echo "   # Then edit .env with your API keys"
    exit 1
fi

# 检查虚拟环境
if [ ! -d "venv" ]; then
    echo "🐍 Creating virtual environment..."
    python -m venv venv
fi

# 激活虚拟环境
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# 安装依赖
echo "📦 Installing dependencies..."
pip install -r requirements.txt

# 运行脚本
SCRIPT_NAME=${1:-agent}

case $SCRIPT_NAME in
    "agent")
        echo "🤖 Running Agent script..."
        python src/agent.py
        ;;
    "clipboard")
        echo "📋 Running Clipboard script..."
        python src/clipboard.py
        ;;
    "notify")
        echo "📢 Running Notify Bugs script..."
        python src/notify_bugs.py
        ;;
    "pause")
        echo "⏸️ Running Pause Agent script..."
        python src/pause_agent.py
        ;;
    *)
        echo "❌ Unknown script: $SCRIPT_NAME"
        echo "📖 Usage: $0 [agent|clipboard|notify|pause]"
        echo "💡 Examples:"
        echo "   $0 agent     # Run the main agent"
        echo "   $0 clipboard # Run clipboard functionality"
        echo "   $0 notify    # Run bug notification"
        echo "   $0 pause     # Run agent controller"
        exit 1
        ;;
esac

echo "✅ Script completed!" 