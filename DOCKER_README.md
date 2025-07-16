# Browser-Use Docker 部署指南

本指南将帮助您使用 Docker 容器化部署 browser-use 项目。

## 🚀 快速开始

### 1. 环境准备

确保您的系统已安装：

- Docker (版本 20.10+)
- Docker Compose (版本 2.0+)

### 2. 配置环境变量

```bash
# 复制环境变量模板
cp env.template .env

# 编辑 .env 文件，填入您的 API 密钥
nano .env
```

必需的环境变量：

- `DEEPSEEK_API_KEY`: 您的 DeepSeek API 密钥

### 3. 构建 Docker 镜像

```bash
# 构建镜像
docker build -t browser-use:latest .

# 或者使用 docker-compose 构建
docker-compose build
```

### 4. 运行容器

#### 方式一：使用 Docker 命令

```bash
# 基础运行
docker run -d \
  --name browser-use-app \
  --env-file .env \
  browser-use:latest

# 带日志卷挂载
docker run -d \
  --name browser-use-app \
  --env-file .env \
  -v $(pwd)/logs:/app/logs \
  browser-use:latest
```

#### 方式二：使用 Docker Compose（推荐）

```bash
# 启动服务
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down
```

## 🔧 高级配置

### 运行不同的脚本

默认情况下，容器运行 `agent.py`。如需运行其他脚本：

```bash
# 运行 clipboard.py
docker-compose run --rm browser-use python src/clipboard.py

# 运行 notify_bugs.py
docker-compose run --rm browser-use python src/notify_bugs.py

# 运行 pause_agent.py
docker-compose run --rm browser-use python src/pause_agent.py
```

### GUI 模式（显示浏览器界面）

如果您想在容器中看到浏览器界面，需要配置 X11 转发：

1. 在宿主机上运行：

```bash
xhost +local:docker
```

2. 修改 `docker-compose.yml`，取消注释 GUI 相关配置：

```yaml
volumes:
  - /tmp/.X11-unix:/tmp/.X11-unix
environment:
  - DISPLAY=${DISPLAY}
network_mode: host
```

3. 设置环境变量：

```bash
export DISPLAY=:0
```

### 性能优化

#### 内存调优

```bash
# 增加内存限制（在 docker-compose.yml 中）
mem_limit: 4g
```

#### 并行处理

```bash
# 运行多个实例
docker-compose up --scale browser-use=3
```

## 📝 常用命令

```bash
# 查看容器状态
docker-compose ps

# 进入容器
docker-compose exec browser-use bash

# 查看实时日志
docker-compose logs -f browser-use

# 重启服务
docker-compose restart browser-use

# 更新镜像
docker-compose pull && docker-compose up -d

# 清理无用镜像
docker system prune -a
```

## 🐛 故障排除

### 常见问题

1. **API 密钥错误**

   ```bash
   # 检查环境变量
   docker-compose exec browser-use env | grep DEEPSEEK
   ```

2. **浏览器启动失败**

   ```bash
   # 检查容器权限
   docker-compose exec browser-use ps aux
   ```

3. **内存不足**
   ```bash
   # 查看内存使用
   docker stats browser-use-app
   ```

### 调试模式

```bash
# 启用调试模式
docker-compose run --rm -e DEBUG=true browser-use python agent.py

# 交互式调试
docker-compose run --rm -it browser-use bash
```

## 📦 生产环境部署

### 安全配置

1. 使用 secrets 管理敏感信息：

```yaml
# docker-compose.prod.yml
secrets:
  deepseek_api_key:
    file: ./secrets/deepseek_api_key.txt
```

2. 限制容器权限：

```yaml
user: "1000:1000"
read_only: true
security_opt:
  - no-new-privileges:true
```

### 监控和日志

```bash
# 集中化日志
docker-compose -f docker-compose.yml -f docker-compose.logging.yml up -d

# 健康检查
docker-compose exec browser-use curl -f http://localhost:8080/health || exit 1
```

## 🔄 更新和维护

```bash
# 1. 停止服务
docker-compose down

# 2. 拉取最新代码
git pull origin main

# 3. 重新构建镜像
docker-compose build --no-cache

# 4. 启动服务
docker-compose up -d

# 5. 验证运行状态
docker-compose logs browser-use
```

## 💡 提示和最佳实践

1. **资源管理**: 定期清理无用的容器和镜像
2. **备份配置**: 保存 `.env` 和 `docker-compose.yml` 的备份
3. **版本控制**: 使用特定的镜像标签而非 `latest`
4. **监控**: 设置容器健康检查和资源监控
5. **安全**: 不要在镜像中硬编码敏感信息

## 📞 支持

如果遇到问题，请检查：

1. Docker 和 Docker Compose 版本
2. 系统资源（内存、磁盘空间）
3. 网络连接
4. 环境变量配置

---

_此文档会随项目更新而更新，建议定期查看最新版本。_
