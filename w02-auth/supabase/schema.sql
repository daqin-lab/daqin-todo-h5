-- 建表
create table todos (
  id bigint generated always as identity primary key,
  title text not null,
  done boolean default false
);

-- 插入三条示例数据（对应效果预览图里的三条）
insert into todos (title) values ('第一条真实数据');
insert into todos (title) values ('这条来自云数据库');
insert into todos (title, done) values ('在后台改一条，刷新就变', true);

-- 放开匿名读写（学习阶段用）
-- 关掉 RLS 后 anon 角色可增删改查，这样页面的"添加""勾选"才能用
-- 正式项目推荐改用 RLS 策略精细授权，例如：
-- create policy "允许所有人读取" on todos for select using (true);
alter table todos disable row level security;
