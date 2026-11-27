# W02 · 不写登录代码，给页面加上真实用户系统

> 公众号「大琴 AI 全栈自由」AI全栈系列第 2 篇配套源码。
> 在 W01 待办页基础上接入 Supabase Auth：**注册 / 登录 / 退出 / 登录态保持**，全套认证不写一行后端。

## 本地跑起来

依赖由仓库根统一管理（npm workspaces），**只需在仓库根目录装一次**，所有周次共用：

```bash
cd daqin-ai-fullstack
npm install                        # 只在根目录装一次，w01~w12 共用
cd w02-auth
cp .env.local.example .env.local   # 填入你的 Supabase URL 和 Key
npm run dev
```

> 如果依赖已在根目录装过，直接 `cd w02-auth && npm run dev` 即可，不用再装。

**Supabase 控制台要先做两件事：**
1. Authentication → Providers → 确认 Email 已启用；学习阶段关掉 "Confirm email"（上线前开回来）
2. SQL Editor 执行 `supabase/schema.sql`（和 W01 同一张表）

## 跑起来看到什么

- **未登录**：显示邮箱 + 密码输入框，两个按钮「登录 / 注册」
- **登录成功后**：顶部显示「欢迎你，xxx」+ 退出按钮，下面是 W01 的待办列表
- **刷新页面**：登录态保持（token 由 Supabase 自动存 Cookie）
- **点退出**：回到登录界面

和文章《W02_登录页效果图.png》两态一致。

## 相对 W01 改了什么

| 文件 | 变化 |
|---|---|
| `src/components/Auth.vue` | **新增**：注册/登录/读登录态/退出全套逻辑，登录成功后 emit `login` 事件 |
| `src/App.vue` | 顶部读 `getUser()`；未登录渲染 `<Auth>`，已登录渲染欢迎条 + W01 待办列表 |
| 其它文件 | 与 W01 完全相同（独立副本，不依赖 W01 目录；依赖共用仓库根的 node_modules） |

## 高频坑

- **提示 Email not confirmed**：Supabase 默认开启邮箱验证，去 Authentication → Providers 关掉 Confirm email
- **读到 null / row-level security**：`schema.sql` 已关掉 RLS
- **改了 .env.local 不生效**：重启 `npm run dev`

> 本目录代码完整独立，不需要先跑 W01；依赖在仓库根目录装一次即可。
