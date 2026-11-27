<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { supabase } from './lib/supabaseClient'

type Todo = { id: number; title: string; done: boolean }
const todos = ref<Todo[]>([])
const newTitle = ref('')
const error = ref<string | null>(null)

// 读取待办（对应预览图里列表的 3 条）
async function getTodos() {
  const { data, error: e } = await supabase.from('todos').select('*').order('id')
  if (e) { error.value = e.message; return }
  todos.value = data ?? []
}

// 添加一条待办
async function addTodo() {
  const title = newTitle.value.trim()
  if (!title) return
  const { data, error: e } = await supabase
    .from('todos').insert({ title }).select()
  if (e) { error.value = e.message; return }
  if (data?.[0]) todos.value.push(data[0] as Todo)
  newTitle.value = ''
}

// 勾选 / 取消勾选
async function toggleTodo(t: Todo) {
  const { error: e } = await supabase
    .from('todos').update({ done: !t.done }).eq('id', t.id)
  if (e) { error.value = e.message; return }
  t.done = !t.done
}

onMounted(getTodos)
</script>

<template>
  <div class="app">
    <!-- 顶部 teal 栏 -->
    <header class="header">
      <h1>我的待办</h1>
      <p>数据来自 Supabase 云数据库</p>
    </header>

    <!-- 主体 -->
    <main class="main">
      <p v-if="error" class="error">读取失败：{{ error }}</p>

      <!-- 待办卡片 -->
      <div v-for="t in todos" :key="t.id" class="todo-card" :class="{ done: t.done }">
        <button class="check" :class="{ checked: t.done }" @click="toggleTodo(t)"
                :aria-label="t.done ? '取消完成' : '标记完成'">
          <span v-if="t.done">✓</span>
        </button>
        <div class="todo-body">
          <div class="todo-title">{{ t.title }}</div>
          <div class="todo-tag">#全栈第一步</div>
        </div>
      </div>

      <!-- 添加框 -->
      <form class="add-bar" @submit.prevent="addTodo">
        <input v-model="newTitle" type="text" placeholder="＋  添加一条待办..." />
        <button type="submit">添加</button>
      </form>
    </main>

    <!-- 底部提示 -->
    <footer class="footer">一个真正在线的全栈页面 · 移动端 H5</footer>
  </div>
</template>

<style scoped>
.app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: #f8fafc;
  max-width: 420px;
  margin: 0 auto;
}
.header {
  background: #0f766e;
  padding: 22px 20px 20px;
  color: #fff;
}
.header h1 { margin: 0 0 6px; font-size: 22px; font-weight: bold; }
.header p { margin: 0; font-size: 12px; color: #ccfbf1; }
.main { flex: 1; padding: 18px; }
.error { color: #dc2626; font-size: 14px; margin: 0 0 12px; }

.todo-card {
  display: flex;
  align-items: flex-start;
  gap: 14px;
  background: #fff;
  border: 1px solid #e5e7eb;
  border-radius: 10px;
  padding: 18px 16px;
  margin-bottom: 12px;
}
.check {
  flex: none;
  width: 22px; height: 22px;
  border: 2px solid #cbd5e1;
  border-radius: 50%;
  background: transparent;
  padding: 0;
  cursor: pointer;
  color: #fff;
  font-size: 13px;
  line-height: 18px;
}
.check.checked { background: #16a34a; border-color: #16a34a; }
.todo-body { flex: 1; min-width: 0; }
.todo-title { font-size: 14px; color: #111827; line-height: 1.4; }
.todo-card.done .todo-title { color: #94a3b8; }
.todo-tag { font-size: 11px; color: #0f766e; margin-top: 6px; }

.add-bar {
  display: flex;
  align-items: center;
  gap: 8px;
  background: #fff;
  border: 2px solid #cbd5e1;
  border-radius: 10px;
  padding: 8px 10px;
  margin-top: 20px;
}
.add-bar input {
  flex: 1; min-width: 0;
  border: none; outline: none;
  font-size: 13px; color: #111827;
  background: transparent;
}
.add-bar input::placeholder { color: #94a3b8; }
.add-bar button {
  flex: none;
  border: none; border-radius: 8px;
  background: #0f766e; color: #fff;
  font-size: 11px; padding: 8px 14px;
  cursor: pointer;
}
.footer {
  text-align: center;
  font-size: 11px;
  color: #6b7280;
  padding: 14px 0 20px;
}
</style>
