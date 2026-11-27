<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { supabase } from '../lib/supabaseClient'

const emit = defineEmits<{ login: [user: any] }>()

const email = ref('')
const password = ref('')
const user = ref<any>(null)
const message = ref('')

onMounted(async () => {
  const { data } = await supabase.auth.getUser()
  user.value = data.user
})

async function signUp() {
  const { error } = await supabase.auth.signUp({
    email: email.value,
    password: password.value
  })
  message.value = error ? error.message : '注册成功，请查收验证邮件'
}

async function signIn() {
  const { error } = await supabase.auth.signInWithPassword({
    email: email.value,
    password: password.value
  })
  if (error) { message.value = error.message; return }
  const { data } = await supabase.auth.getUser()
  user.value = data.user
  emit('login', data.user)
}

async function signOut() {
  await supabase.auth.signOut()
  user.value = null
  message.value = '已退出登录'
}
</script>

<template>
  <div class="auth">
    <p v-if="message" class="msg">{{ message }}</p>

    <template v-if="!user">
      <h2>登录 / 注册</h2>
      <input v-model="email" type="email" placeholder="邮箱" />
      <input v-model="password" type="password" placeholder="密码" />
      <button @click="signIn">登录</button>
      <button @click="signUp">注册</button>
    </template>

    <template v-else>
      <p class="welcome">欢迎你，{{ user.email }}</p>
      <button class="logout" @click="signOut">退出登录</button>
    </template>
  </div>
</template>

<style scoped>
.auth { max-width: 360px; margin: 40px auto; padding: 0 20px; font-family: system-ui, sans-serif; }
.auth h2 { font-size: 20px; color: #0f766e; }
.auth input { display: block; width: 100%; padding: 10px; margin: 10px 0; box-sizing: border-box; border: 1px solid #cbd5e1; border-radius: 6px; }
.auth button { padding: 10px 20px; margin: 5px 5px 5px 0; cursor: pointer; border: none; border-radius: 6px; background: #0f766e; color: #fff; }
.msg { color: #b45309; font-size: 14px; }
.welcome { font-size: 16px; color: #111827; }
.logout { background: #dc2626 !important; }
</style>
