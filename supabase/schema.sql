-- 建表
create table todos (
  id bigint generated always as identity primary key,
  title text not null,
  done boolean default false
);

-- 插入两条真实数据
insert into todos (title) values ('第一条真实数据');
insert into todos (title) values ('这条来自云数据库');

-- 允许匿名读取（学习阶段用，等价于关掉 RLS 限制）
-- 正式项目推荐改用 RLS 策略精细授权，例如：
-- create policy "允许所有人读取" on todos for select using (true);
alter table todos disable row level security;
