# Browser-Use Project Makefile

.PHONY: help install dev-install test lint format build clean docker-build docker-run docker-clean setup

# 默认目标
help:
	@echo "Browser-Use Project - Available Commands:"
	@echo ""
	@echo "🚀 Setup & Installation:"
	@echo "  make setup          - Initial project setup"
	@echo "  make install        - Install production dependencies"
	@echo "  make dev-install    - Install development dependencies"
	@echo ""
	@echo "🧪 Development:"
	@echo "  make test           - Run tests"
	@echo "  make lint           - Run linting"
	@echo "  make format         - Format code with black"
	@echo "  make check          - Run all checks (lint + test)"
	@echo ""
	@echo "🏗️ Build & Package:"
	@echo "  make build          - Build the project"
	@echo "  make clean          - Clean build artifacts"
	@echo ""
	@echo "🐳 Docker:"
	@echo "  make docker-build   - Build Docker image"
	@echo "  make docker-run     - Run with Docker Compose"
	@echo "  make docker-clean   - Clean Docker containers and images"
	@echo ""
	@echo "🚀 Run Scripts:"
	@echo "  make run-agent      - Run main agent"
	@echo "  make run-clipboard  - Run clipboard functionality"
	@echo "  make run-notify     - Run bug notification"
	@echo "  make run-pause      - Run agent controller"

# 项目初始设置
setup:
	@echo "🔧 Setting up project..."
	cp env.template .env
	@echo "📝 Please edit .env file with your API keys"
	@echo "✅ Setup complete!"

# 安装生产依赖
install:
	@echo "📦 Installing production dependencies..."
	pip install -r requirements.txt

# 安装开发依赖
dev-install:
	@echo "📦 Installing development dependencies..."
	pip install -r requirements.txt
	pip install -e ".[dev]"
	pre-commit install

# 运行测试
test:
	@echo "🧪 Running tests..."
	python -m pytest tests/ -v --cov=src --cov-report=term-missing

# 代码检查
lint:
	@echo "🔍 Running linting..."
	flake8 src/ tests/
	mypy src/

# 代码格式化
format:
	@echo "🎨 Formatting code..."
	black src/ tests/
	isort src/ tests/

# 运行所有检查
check: lint test
	@echo "✅ All checks passed!"

# 构建项目
build: clean
	@echo "🏗️ Building project..."
	python -m build

# 清理构建文件
clean:
	@echo "🧹 Cleaning build artifacts..."
	rm -rf build/ dist/ *.egg-info/
	find . -type d -name __pycache__ -delete
	find . -type f -name "*.pyc" -delete

# Docker 构建
docker-build:
	@echo "🐳 Building Docker image..."
	docker-compose build

# Docker 运行
docker-run:
	@echo "🚀 Starting Docker services..."
	docker-compose up -d

# Docker 清理
docker-clean:
	@echo "🧹 Cleaning Docker containers and images..."
	docker-compose down
	docker system prune -f

# 运行脚本
run-agent:
	@echo "🤖 Running main agent..."
	python src/agent.py

run-clipboard:
	@echo "📋 Running clipboard functionality..."
	python src/clipboard.py

run-notify:
	@echo "📢 Running bug notification..."
	python src/notify_bugs.py

run-pause:
	@echo "⏸️ Running agent controller..."
	python src/pause_agent.py

# 开发服务器（如果需要的话）
dev:
	@echo "🔧 Starting development mode..."
	python src/agent.py

# 安装 pre-commit hooks
hooks:
	@echo "🪝 Installing pre-commit hooks..."
	pip install pre-commit
	pre-commit install

# 发布到 PyPI（需要配置）
publish: build
	@echo "📤 Publishing to PyPI..."
	twine upload dist/*

# 版本更新
bump-patch:
	@echo "🏷️ Bumping patch version..."
	bump2version patch

bump-minor:
	@echo "🏷️ Bumping minor version..."
	bump2version minor

bump-major:
	@echo "🏷️ Bumping major version..."
	bump2version major 