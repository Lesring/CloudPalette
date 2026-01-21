# 🚀 部署指南

## 📋 项目概述

这是一个前端静态网站为主的智能配色生成器项目。可通过纯静态托管（推荐，零成本）或使用内置的 Node/Express 服务器提供静态文件与少量演示接口（/health、/api/stats）。并提供 Docker 与 Docker Compose 部署方式。

## 🛠️ 环境要求

- Node.js >= 16.0.0
- npm >= 8.0.0
- Docker >= 20.0.0（可选）
- Docker Compose >= 2.0.0（可选）

## 🚀 部署方式（按成本与复杂度排序）

### 方式一：纯静态托管（推荐，零后端）

适用于无需自定义服务器逻辑的场景。网站主要是静态页面（`index.html` 等），可直接托管至：
- GitHub Pages
- Vercel（Static）
- Cloudflare Pages

#### A. GitHub Pages
1. 将仓库推送至 GitHub。
2. 在仓库 Settings → Pages，Source 选择 `Deploy from a branch`，分支选择 `main`，目录选择 `/ (root)`。
3. 保存后等待 Pages 生效，访问生成的链接。

注意：GitHub Pages 不支持项目内的演示接口（如 `/api/stats`）。如需这些接口，请使用下面的 Node/Express 或 Docker 方式。

#### B. Vercel（静态）
1. 在 Vercel 新建项目，关联本仓库。
2. Root Directory 选择仓库根目录；Framework 选择 `Other`；不需要 Build 命令。
3. Output Directory 指向根目录（默认即可）。
4. 部署完成后即可访问。

### 方式二：Node/Express 部署（提供演示接口）

#### 1. 安装依赖
```bash
npm install
```

#### 2. 启动服务（开发/生产）
```bash
# 开发环境（含自动重载）
npm run dev

# 生产环境
npm start
```


### 方式三：Docker 部署

#### 1. 构建镜像
```bash
docker build -t color-palette-generator .
```

#### 2. 运行容器
```bash
# 生产环境（单容器）
docker run -d -p 3000:3000 --name color-palette color-palette-generator

# 或使用 docker-compose（包含 dev 配置）
docker-compose up -d
```

#### 3. 开发环境
```bash
docker-compose --profile dev up -d
```

### 方式四：使用启动脚本（可选）

#### 1. 设置权限
```bash
chmod +x entrypoint.sh
```

#### 2. 运行脚本
```bash
./entrypoint.sh
```

## 🔧 环境变量配置

### 基础配置
```bash
NODE_ENV=production    # 环境模式：development/production
PORT=3000             # 服务端口
```

示例环境文件见仓库根目录的 `env.example`（复制为 `.env` 即可使用）。当前服务器默认已启用 Helmet 安全头与压缩，无需额外环境变量开启。


### 查看日志
- 本地开发/生产：查看控制台输出即可（`npm run dev` / `npm start`）。
- Docker：`docker-compose logs -f` 或 `docker logs color-palette-generator`。

## 🔒 安全配置

- 已默认启用 Helmet（含 CSP）。如需自定义 CSP 或允许第三方资源，请调整 `server.js` 中的 Helmet 配置。
- CORS：开发环境默认允许 `http://localhost:3000`；生产环境默认允许 `https://your-domain.com`。上线前请在 `server.js` 中将该域名替换为你的真实域名。
- 建议在生产环境通过反向代理或平台配置启用 HTTPS。

## 📈 性能优化

### 静态文件优化
- 已启用 gzip 压缩（`compression`）。
- 已设置缓存头（`maxAge: 1d`）。
- 已开启 ETag 与 Last-Modified。

### 服务器建议
- 可结合 PM2 等进程管理器使用（本项目未内置）。
- 前置 CDN/反向代理可进一步提升性能（可选）。

## 🐳 Docker优化

当前 `Dockerfile` 采用 `node:18-alpine` 单阶段构建，`npm ci --only=production` 安装依赖，使用非 root 用户运行，并内置 `/health` 健康检查。若需更小镜像，可自行改造为多阶段构建。

## 🔄 持续部署

### GitHub Actions（最小示例：Node 版本校验与 Docker 构建）
```yaml
name: CI

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
    - name: Install dependencies
      run: npm ci --prefer-offline
    - name: Docker build (optional)
      run: docker build -t color-palette-generator .
```

## 🚨 故障排除

### 常见问题

#### 1. 端口被占用
```bash
# 查看端口占用
netstat -tlnp | grep :3000

# 杀死进程
kill -9 <PID>
```

#### 2. 权限问题
```bash
# 修复文件权限
chmod +x entrypoint.sh
#（Dockerfile 内已设置非 root 用户，通常无需手工 chown）
```

#### 3. 内存不足
```bash
# 增加Node.js内存限制
node --max-old-space-size=2048 server.js
```

#### 4. Docker容器无法启动
```bash
# 查看容器日志
docker logs color-palette-generator

# 重新构建镜像
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

（本项目未内置独立日志文件目录，如需文件日志请自行添加日志方案。）

## 📞 技术支持

如果遇到问题，请检查：
1. 环境变量配置
2. 端口是否被占用
3. 依赖是否正确安装
4. 控制台或容器日志输出中的错误信息

## 📚 相关文档

- [Node.js官方文档](https://nodejs.org/docs/)
- [Express.js文档](https://expressjs.com/)
- [Docker官方文档](https://docs.docker.com/)

---

**祝您部署顺利！** 🎉 