# 🌌 StarryPoints · CloudPalette 配色工具

面向设计师与美术爱好者的配色工具集合。首页 `index.html` 是创意工具的聚合页（StarryPoints），当前已收录 CloudPalette 模块：
- Explore 探索模式：多风格随机/和谐配色生成与编辑
- Professional 专业模式：基于主色一键生成多种和谐方案与色彩系统
- AI 拓展（实验性）：颜色/配色分析、文字生成配色、配色建议（前端演示版）

## 🗺️ 项目结构与页面关系
- `index.html`：工具聚合与导航（当前提供 CloudPalette）
  - 入口按钮跳转：
    - `explore.html`（探索模式）
    - `professional.html`（专业模式）
    - `ai.html`（AI 拓展，待完善）
- 可选 `server.js`（Express）用于本地/容器静态托管与演示接口（`/health`、`/api/stats`）

## ✨ 模块与功能

### 🌟 Explore 探索模式（`explore.html`）
- **生成类型**
  - 随机配色（更接近实际设计场景的多维随机）
  - 美学随机·协调 / 美学随机·对比
  - 类似色、互补色（固定 2 色）、三角配色（固定 3 色）、单色配色
- **可选色彩空间**
  - 标准色、传统/艺术与风格色：`chinese | japanese | morandi | matisse | mondrian | vangogh | picasso | dunhuang | rococo | memphis | macaron | cream | monet | ral | ncs | cyberpunk | pop`
  - 不同空间对“饱和度/对比度”调节支持不同（UI 会自动禁用不支持的选项）
- **生成控制**
  - 颜色数量：1–11（部分类型固定数量）
  - 饱和度/对比度：分档调节（very-low → very-high）
- **单色块操作**
  - 锁定、随机此色、变深、变浅、自定义（输入十六进制）
  - 点击复制颜色（自动选择可读的文字色）
- **历史与导出**
  - 历史记录（最多 50 条，`localStorage` 持久化）
  - 保存到本地、导出 CSS / JSON / TXT
- **交互与体验**
  - 暗色模式切换（偏好保存到 `localStorage`）
  - 快捷键：空格键重新生成配色
  - 自适应布局与移动端触摸优化

### ⚡ Professional 专业模式（`professional.html`）
- **基于主色生成 6 种标准和谐方案**
  - 类似色 / 互补色 / 三角配色 / 分裂互补 / 四分配色 / 单色配色
  - 每种均按风格主题（现代/自然/优雅/活力/复古/科技）对饱和度与明度进行细微调整
- **色彩系统输出**
  - 主色（含多个权重）、辅助色、强调色（自动选取对比度高者）、中性色（浅/中/深）
  - 支持点击复制
- **主色选择与主题**
  - 文本输入十六进制
  - 色盘（H/S/L）微调并实时预览
  - 暗色模式切换（与探索模式偏好同步）
- **导出**
  - CSS / JSON / TXT

### 🧪 AI 拓展（实验功能，`ai.html`）
- **功能卡片**
  - AI 颜色分析（演示）
  - AI 配色分析（演示）
  - 文字生成配色（演示）
  - 智能配色建议（演示）
- 当前为前端演示版，无服务端模型调用；通过延时模拟结果，便于交互流程验证与 UI 预演。

## 🚀 使用与运行

### 方式一：直接打开（推荐，纯静态）
- 双击或通过本地 HTTP 服务打开 `index.html` 即可使用全部前端功能
- 推荐使用 VS Code Live Server、`python -m http.server` 等本地静态服务以避免部分浏览器安全策略限制

### 方式二：Node/Express 静态托管（可选）
```bash
npm install
npm run dev   # 开发
npm start     # 生产
```
默认端口 `3000`，可通过环境变量覆盖（见下文）。

### 方式三：Docker（可选）
```bash
docker build -t color-palette-generator .
docker run -d -p 3000:3000 --name color-palette color-palette-generator
# 或 docker-compose
docker-compose up -d
```

## ⚙️ 配置
环境变量（仅在使用 `server.js` 托管时有效）：
```bash
NODE_ENV=production  # development/production
PORT=3000            # 访问端口
```
示例见 `env.example`，复制为 `.env` 即可。

## 📁 文件结构
```
.
├── index.html            # 聚合页（StarryPoints）
├── explore.html          # CloudPalette · 探索模式
├── professional.html     # CloudPalette · 专业模式
├── ai.html               # CloudPalette · AI 拓展（演示）
├── contact.html          # 联系页
├── server.js             # 可选：Express 静态托管 + /health /api/stats
├── package.json
├── Dockerfile
├── docker-compose.yml
├── entrypoint.sh
├── start.sh
├── CloudPalette.svg
├── CloudPalette.ico
├── LICENSE
├── .gitignore
├── .dockerignore
└── env.example
```

## 🧩 交互细节与快捷键
- 点击色块复制颜色（含提示）
- 空格键：在 Explore/Professional 中重新生成方案
- 主题切换：亮/暗（偏好保存在 `localStorage`，页面间同步）
- Explore 的互补/三角配色为固定 2/3 色，其余类型支持 1–11 色

## 🛠️ 技术要点
- 纯前端 HTML/CSS/JavaScript 实现，`localStorage` 存储历史与偏好
- 响应式布局；暗色模式完整适配
- 可选 Node/Express 静态托管与健康检查
- Docker/Compose 支持

## 🗺️ Roadmap
- AI 拓展接入真实推理服务（本地/云端），支持 API Key 与速率控制
- 无障碍与对比度检测（WCAG）评分与修正建议
- 方案分享与短链、批量导出（Token、Tailwind、CSS 变量、Design Token）
- 更丰富的专业模式规则与品牌系统模板
- PWA 与离线增强

## 🤝 贡献
欢迎提交 Issue / PR 改进功能与体验。

## 📄 许可证
MIT License — 详见 `LICENSE`

---
享受探索色彩的过程！🎨✨