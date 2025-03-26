<template>
  <div class="sm:mx-auto sm:w-full sm:max-w-sm">
    <img
      class="mx-auto h-36 w-auto"
      src="src/assets/astro-logo-light-gradient.svg"
      alt="Astro"
    />
    <h2
      class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-white"
    >
      Sign in to your account
    </h2>
  </div>

  <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
    <form class="space-y-6" method="POST" @submit.prevent="handleSubmit">
      <div>
        <label for="email" class="block text-sm/6 font-medium text-white"
          >Email address</label
        >
        <div class="mt-2">
          <input
            v-model="form.email"
            type="email"
            name="email"
            id="email"
            autocomplete="email"
            required
            class="block w-full rounded-md bg-white/5 px-3 py-1.5 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500 sm:text-sm/6"
          />
        </div>
      </div>

      <div>
        <div class="flex items-center justify-between">
          <label for="password" class="block text-sm/6 font-medium text-white"
            >Password</label
          >
          <div class="text-sm">
            <a
              href="/forgot-password"
              class="font-semibold text-indigo-400 hover:text-indigo-300"
              >Forgot password?</a
            >
          </div>
        </div>
        <div class="mt-2">
          <input
            v-model="form.password"
            type="password"
            name="password"
            id="password"
            autocomplete="current-password"
            required
            class="block w-full rounded-md bg-white/5 px-3 py-1.5 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500 sm:text-sm/6"
          />
        </div>
      </div>

      <div>
        <button
          type="submit"
          class="flex w-full justify-center rounded-md bg-indigo-500 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-xs hover:bg-indigo-400 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500"
        >
          Sign in
        </button>
      </div>
    </form>

    <p class="mt-10 text-center text-sm/6 text-gray-400">
      Not a member?
      {{ ' ' }}
      <a
        href="/sign-up"
        class="font-semibold text-indigo-400 hover:text-indigo-300"
        >Sign up</a
      >
    </p>
  </div>
</template>

<script setup lang="ts">
import { reactive } from 'vue'
import { authClient } from '../lib/auth-client' //import the auth client

const form = reactive({
  email: '',
  password: '',
})

async function handleSubmit() {
  try {
    const { data, error } = await authClient.signIn.email(
      {
        email: form.email,
        password: form.password,
      },
      {
        onSuccess: () => {
          window.location.href = '/' // Redirect to the home page or dashboard
        },
      },
    )
  } catch (error) {
    console.error('Sign in failed:', error)
    // Handle sign-in error (e.g., show error message)
  }
}
</script>
