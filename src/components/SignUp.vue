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
      Create your account
    </h2>
  </div>

  <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
    <form class="space-y-6" method="POST" @submit.prevent="handleSubmit">
      <div>
        <label for="name" class="block text-sm/6 font-medium text-white"
          >Full name</label
        >
        <div class="mt-2">
          <input
            type="text"
            name="name"
            id="name"
            autocomplete="name"
            required
            class="block w-full rounded-md bg-white/5 px-3 py-1.5 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500 sm:text-sm/6"
            v-model="form.name"
          />
        </div>
      </div>

      <div>
        <label for="email" class="block text-sm/6 font-medium text-white"
          >Email address</label
        >
        <div class="mt-2">
          <input
            type="email"
            name="email"
            id="email"
            autocomplete="email"
            required
            class="block w-full rounded-md bg-white/5 px-3 py-1.5 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500 sm:text-sm/6"
            v-model="form.email"
          />
        </div>
      </div>

      <div>
        <label for="password" class="block text-sm/6 font-medium text-white"
          >Create password</label
        >
        <div class="mt-2">
          <input
            type="password"
            name="password"
            id="password"
            autocomplete="new-password"
            required
            class="block w-full rounded-md bg-white/5 px-3 py-1.5 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500 sm:text-sm/6"
            v-model="form.password"
          />
        </div>
      </div>

      <div>
        <label
          for="confirm-password"
          class="block text-sm/6 font-medium text-white"
          >Confirm password</label
        >
        <div class="mt-2">
          <input
            type="password"
            name="confirm-password"
            id="confirm-password"
            autocomplete="new-password"
            required
            class="block w-full rounded-md bg-white/5 px-3 py-1.5 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500 sm:text-sm/6"
            v-model="form.confirmPassword"
          />
        </div>
      </div>

      <div>
        <button
          type="submit"
          class="flex w-full justify-center rounded-md bg-indigo-500 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-xs hover:bg-indigo-400 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500"
        >
          Sign up
        </button>
      </div>
    </form>

    <p class="mt-10 text-center text-sm/6 text-gray-400">
      Already have an account?
      {{ ' ' }}
      <a
        href="/sign-in"
        class="font-semibold text-indigo-400 hover:text-indigo-300"
        >Sign in</a
      >
    </p>
  </div>
</template>

<script setup lang="ts">
import { reactive } from 'vue'
import { authClient } from '../lib/auth-client' //import the auth client

const form = reactive({
  name: '',
  email: '',
  password: '',
  confirmPassword: '',
})

async function handleSubmit() {
  const { name, email, password } = form

  // Perform validation here if needed
  if (!name || !email || !password) {
    alert('Please fill in all fields')
    return
  }

  if (password !== form.confirmPassword) {
    alert('Passwords do not match')
    return
  }

  // Call the sign-up function from the auth client
  try {
    const { data, error } = await authClient.signUp.email(
      {
        email, // user email address
        password, // user password -> min 8 characters by default
        name, // user display name
        callbackURL: '/',
      },
      {
        onRequest: (ctx) => {
          //show loading
        },
        onSuccess: (ctx) => {
          window.location.href = '/' // redirect to the home page
        },
        onError: (ctx) => {
          // display the error message
          alert(ctx.error.message)
        },
      },
    )
  } catch (error) {
    console.error('Error during sign-up:', error)
  }
}
</script>
