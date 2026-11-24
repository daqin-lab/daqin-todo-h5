<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { supabase } from './lib/supabaseClient'

type Todo = { id: number; title: string; done: boolean }
const todos = ref<Todo[]>([])
const error = ref<string | null>(null)

async function getTodos() {
  const { data, error: e } = await supabase.from('todos').select('*')
  if (e) { error.value = e.message; return }
  todos.value = data ?? []
}
onMounted(getTodos)
</script>

<template>
  <main style="max-width:420px;margin:40px auto;padding:0 20px;">
    <h1 style="color:#0f766e;">我的待办</h1>
    <p v-if="error" style="color:#dc2626;">读取失败：{{ error }}</p>
    <ul v-else>
      <li v-for="t in todos" :key="t.id" style="padding:10px 0;border-bottom:1px solid #e5e7eb;">
        {{ t.title }}
      </li>
    </ul>
  </main>
</template>
