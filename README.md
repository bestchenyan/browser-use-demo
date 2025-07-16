# Browser-Use 项目

一个基于 Python 的浏览器自动化项目，使用 DeepSeek AI 模型和 browser-use 库来实现智能网页操作。

## 🚀 功能特性

- **智能价格比较** (`agent.py`) - 自动比较 GPT-4o 和 DeepSeek-V3 的价格
- **剪贴板操作** (`clipboard.py`) - 实现文本复制粘贴和地图搜索功能
- **Bug 通知系统** (`notify_bugs.py`) - 自动检查禅道 Bug 并发送飞书通知
- **Agent 控制器** (`pause_agent.py`) - 提供启动、暂停、恢复和停止功能

## 📁 项目结构

```
browser-use/
├── src/                    # 源代码目录
│   ├── agent.py           # 主要的智能代理
│   ├── clipboard.py       # 剪贴板功能
│   ├── notify_bugs.py     # Bug 通知功能
│   └── pause_agent.py     # Agent 控制器
├── requirements.txt       # Python 依赖
├── Dockerfile            # Docker 镜像配置
├── docker-compose.yml    # Docker Compose 配置
├── .dockerignore         # Docker 忽略文件
├── .gitignore           # Git 忽略文件
├── env.template         # 环境变量模板
├── DOCKER_README.md     # Docker 部署指南
└── README.md           # 项目说明（本文件）
```

## 🛠️ 环境要求

- Python 3.11+
- Docker (可选，用于容器化部署)
- DeepSeek API 密钥

## ⚡ 快速开始

### 方法一：本地运行

1. **克隆项目**

   ```bash
   git clone <your-repo-url>
   cd browser-use
   ```

2. **安装依赖**

   ```bash
   pip install -r requirements.txt
   ```

3. **配置环境变量**

   ```bash
   cp env.template .env
   # 编辑 .env 文件，填入您的 DEEPSEEK_API_KEY
   ```

4. **运行脚本**

   ```bash
   # 运行主要代理
   python src/agent.py

   # 运行其他功能
   python src/clipboard.py
   python src/notify_bugs.py
   python src/pause_agent.py
   ```

### 方法二：Docker 运行

1. **配置环境变量**

   ```bash
   cp env.template .env
   # 编辑 .env 文件
   ```

2. **启动服务**

   ```bash
   docker-compose up -d
   ```

3. **查看日志**
   ```bash
   docker-compose logs -f
   ```

详细的 Docker 部署说明请参考 [DOCKER_README.md](DOCKER_README.md)

## 📋 配置说明

### 环境变量

在 `.env` 文件中配置以下变量：

| 变量名               | 描述                   | 必需 |
| -------------------- | ---------------------- | ---- |
| `DEEPSEEK_API_KEY`   | DeepSeek API 密钥      | 是   |
| `FEISHU_WEBHOOK_URL` | 飞书机器人 Webhook URL | 否   |
| `HEADLESS`           | 浏览器无头模式         | 否   |
| `BROWSER_WIDTH`      | 浏览器宽度             | 否   |
| `BROWSER_HEIGHT`     | 浏览器高度             | 否   |

### 脚本说明

#### `src/agent.py`

- 主要的智能代理脚本
- 比较 GPT-4o 和 DeepSeek-V3 的价格
- 自动发送结果到飞书群聊

#### `src/clipboard.py`

- 剪贴板操作功能
- 搜索地理位置信息
- 地图搜索和导航

#### `src/notify_bugs.py`

- 禅道 Bug 检查
- 自动登录和数据抓取
- 飞书通知集成

#### `src/pause_agent.py`

- Agent 生命周期管理
- 支持启动、暂停、恢复、停止操作
- 多线程控制

## 🔧 开发指南

### 添加新功能

1. 在 `src/` 目录下创建新的 Python 文件
2. 按照现有代码风格编写功能
3. 更新 `requirements.txt` 如果需要新依赖
4. 更新 `README.md` 说明新功能

### 代码规范

- 使用 Python 3.11+ 语法
- 遵循 PEP 8 代码风格
- 添加适当的注释和文档字符串
- 使用类型注解

## 🐛 故障排除

### 常见问题

1. **API 密钥错误**

   - 检查 `.env` 文件中的 `DEEPSEEK_API_KEY` 是否正确
   - 验证 API 密钥是否有效

2. **浏览器启动失败**

   - 确保系统已安装 Chrome 或 Chromium
   - 检查是否有足够的系统权限

3. **依赖安装失败**
   - 升级 pip：`pip install --upgrade pip`
   - 使用虚拟环境：`python -m venv venv && source venv/bin/activate`

### 调试模式

启用调试模式来获取更多信息：

```bash
# 设置调试环境变量
export DEBUG=true
export LOG_LEVEL=DEBUG

# 运行脚本
python src/agent.py
```

## 📄 许可证

本项目采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

1. Fork 本项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📞 支持

如果遇到问题或需要帮助：

1. 查看 [故障排除](#-故障排除) 部分
2. 搜索现有的 [Issues](../../issues)
3. 创建新的 [Issue](../../issues/new)

---

**注意**: 请确保妥善保管您的 API 密钥，不要将其提交到公共仓库中。
