# 我的待办 · Vue3 + Supabase 移动端 H5

> 配套公众号「大琴 AI 全栈自由」第 1 周周二动手篇《10 分钟让页面连上真实数据库》的完整源码。
> 仓库地址：https://github.com/daqin-lab/daqin-ai-fullstack
> 一个零后端代码、却连着真实云数据库的移动端待办页 —— 全栈的最小闭环：**页面 → 数据库 → 页面**。
>
> **本目录代码完整独立**，不依赖其它周次。依赖由仓库根统一管理（npm workspaces）——**只需在仓库根目录装一次**，所有周次共用。

## 技术栈

Vue 3（`<script setup lang="ts">`）+ TypeScript + Vite + Supabase（现成的云数据库和 REST API）。

## 本地跑起来

**1. 装依赖（仓库根目录，只需一次）**

```bash
# 回到仓库根目录
cd ..
npm install                          # 装一次，w01~w12 全部共用
cd w01-todo-db                       # 再进本周目录
```

> 如果你是跟着仓库根目录 README 操作的，依赖应该已经装好了，这步可以跳过。

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

浏览器打开 http://localhost:5173 ，看到和文章效果预览图一样的页面就成了。

## 页面功能

和效果预览图完全一致：

- **三条示例数据**：前两条未完成（空心圈），第三条"在后台改一条，刷新就变"是已完成（绿色勾）
- **勾选 / 取消勾选**：点圆圈即可切换完成状态，实时写回数据库
- **添加待办**：底部输入框输入内容，按回车或点"添加"，新待办写入数据库
- **标签**：每条待办下方带 `#全栈第一步` 标签

所有操作都直接读写 Supabase 云数据库——你在 Table Editor 改一条数据、刷新页面，页面跟着变。

## 目录结构

```
w01-todo-db/
├── src/
│   ├── lib/supabaseClient.ts   # Supabase 客户端（读 VITE_ 环境变量）
│   ├── App.vue                 # 页面：查询/添加/勾选待办 + 完整样式（对应效果预览图）
│   ├── main.ts                 # 应用入口
│   ├── style.css               # 基础样式
│   └── vite-env.d.ts           # import.meta.env 的 TS 类型声明
├── supabase/schema.sql         # 建表 + 插入示例数据 + RLS 设置
├── .env.local.example          # 环境变量模板（复制成 .env.local）
├── index.html
├── vite.config.ts
└── tsconfig.json
```

## 三个高频坑

- **执行建表 SQL 时弹出 "Run without RLS / Run and enable RLS" 警告**：点 **Run without RLS**。这个 demo 要让匿名身份能读写，表不能有 RLS；选了 enable 就会读到 null、页面空白。
- **读到 null / 提示 row-level security policy**：新表默认开 RLS，匿名读不到。`schema.sql` 里已关掉；正式项目请改成 RLS 策略精细授权。
- **改了 .env.local 不生效**：Vite 不会热更新环境变量，改完要重启 `npm run dev`。

> 本地排障：如果 `npm install` 报 `EACCES / Permission denied`，多半是 `~/.npm` 缓存目录有 root 权限的旧文件（`sudo chown -R $(whoami) ~/.npm` 修复），与项目本身无关。

## 关于

一人即团队，全栈即自由。关注公众号「大琴 AI 全栈自由」，每周二、周四各一篇，一起从前端走到全栈。
