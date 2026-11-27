# 大琴 AI 全栈自由 · 12 周源码仓库

> 配套公众号「大琴 AI 全栈自由」AI全栈系列 24 篇文章的源码。
> **每周一个独立目录，看哪篇进哪个目录**，代码各自完整、不用从头累积；依赖由仓库统一管理，**只在根目录装一次**。

一人即团队，全栈即自由。

## 目录说明

```
daqin-ai-fullstack/
├── package.json         仓库统一依赖（npm workspaces）
├── w01-todo-db/         W01 · 10 分钟让页面连上真实数据库（Vue3 + Supabase 待办页）
├── w02-auth/            W02 · 不写登录代码，给页面加上真实用户系统（注册/登录/退出）
├── w03-deploy/          W03 · 把页面部署上线（待发布）
└── ...                  W04~W12 按周追加
```

## 怎么用

只需在**根目录装一次依赖**，所有周次共用，不用每周重复安装：

```bash
git clone https://github.com/daqin-lab/daqin-ai-fullstack.git
cd daqin-ai-fullstack
npm install                          # 只在根目录装一次，所有周次共用
cd w02-auth                          # 进你想看的那一周
cp .env.local.example .env.local     # 填入你的 Supabase URL 和 Key
npm run dev                          # 跑起来就是当周效果图
```

- 每个目录都有完整的 `src/`、`supabase/`、配置文件，`cd` 进去就能跑
- 想跑别的周次，直接 `cd w01-todo-db` 再 `npm run dev`，**不用再装依赖**
- 也可以在根目录用 `npm run dev:w01` / `npm run dev:w02` 快捷启动
- 各目录的 `supabase/schema.sql` 是对应周次的建表 SQL

## 已发布周次

| 周次 | 主题 | 目录 | 状态 |
|---|---|---|---|
| W01 | 10 分钟连上真实数据库 | `w01-todo-db/` | ✅ 可用 |
| W02 | 不写代码实现用户系统 | `w02-auth/` | ✅ 可用 |
| W03~W12 | 部署 / 接口 / 数据库 / 登录原理 / … | — | 随文章发布追加 |

## 技术栈

主线 Vue 3 + TypeScript + Vite + Supabase；后续周次按需引入 Node.js 接口、Prisma、JWT 等（届时各目录会写明自己的技术栈，互不干扰）。

## 关于

关注公众号「大琴 AI 全栈自由」，每周二动手篇、周四认知篇，一起从前端走到全栈。完整文章与路线图见公众号菜单。
