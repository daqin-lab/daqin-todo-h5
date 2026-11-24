# 我的待办 · Vue3 + Supabase 移动端 H5

> 配套公众号「大琴 AI 全栈自由」第 1 周周二动手篇《10 分钟让页面连上真实数据库》的完整源码。
> 仓库地址：https://github.com/daqin-lab/daqin-todo-h5
> 一个零后端代码、却连着真实云数据库的移动端待办页 —— 全栈的最小闭环：**页面 → 数据库 → 页面**。

## 技术栈

Vue 3（`<script setup lang="ts">`）+ TypeScript + Vite + Supabase（现成的云数据库和 REST API）。

## 本地跑起来（3 步）

**1. 装依赖**

```bash
npm install
```

**2. 配环境变量**

把 `.env.local.example` 复制成 `.env.local`，填入你自己 Supabase 项目的值：

```env
VITE_SUPABASE_URL=https://你的项目.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY=你的publishable key
```

> 两个值在 Supabase 控制台 → Project Settings → API 里拿。新版叫 Publishable key，旧版叫 anon key，是同一个值。`.env.local` 已在 `.gitignore` 里，不会泄露。

**3. 建表 + 启动**

在 Supabase 控制台左侧 SQL Editor 里执行 `supabase/schema.sql`，然后：

```bash
npm run dev
```

浏览器打开 http://localhost:5173 ，看到"第一条真实数据""这条来自云数据库"就成了。去 Table Editor 改一条数据、刷新页面，会跟着变。

## 目录结构

```
daqin-todo-h5/
├── src/
│   ├── lib/supabaseClient.ts   # Supabase 客户端（读 VITE_ 环境变量）
│   ├── App.vue                 # 页面：onMounted 里查数据，ref 存数据
│   ├── main.ts                 # 应用入口
│   ├── style.css               # 基础样式
│   └── vite-env.d.ts           # import.meta.env 的 TS 类型声明
├── supabase/schema.sql         # 建表 + 插入示例数据 + RLS 设置
├── .env.local.example          # 环境变量模板（复制成 .env.local）
├── index.html
├── vite.config.ts
└── tsconfig.json
```

## 两个高频坑

- **读到 null / 提示 row-level security policy**：新表默认开 RLS，匿名读不到。`schema.sql` 里已关掉；正式项目请改成 RLS 策略精细授权。
- **改了 .env.local 不生效**：Vite 不会热更新环境变量，改完要重启 `npm run dev`。

## 关于

一人即团队，全栈即自由。关注公众号「大琴 AI 全栈自由」，每周二、周五各一篇，一起从前端走到全栈。
