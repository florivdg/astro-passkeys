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
            autocomplete="email webauthn"
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
            autocomplete="current-password webauthn"
            required
            class="block w-full rounded-md bg-white/5 px-3 py-1.5 text-base text-white outline-1 -outline-offset-1 outline-white/10 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-500 sm:text-sm/6"
          />
        </div>
      </div>

      <div class="space-y-2.5">
        <button
          type="submit"
          class="flex w-full justify-center rounded-md bg-white/10 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-xs hover:bg-white/20 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500"
        >
          Sign in
        </button>

        <button
          type="button"
          class="flex w-full items-center justify-center gap-x-1.5 rounded-md bg-indigo-500 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-xs hover:bg-indigo-400 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500"
          @click="handleSignInWithPasskey"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="currentColor"
            class="-ml-0.5 size-5"
          >
            <path
              fill-rule="evenodd"
              d="M15.75 1.5a6.75 6.75 0 0 0-6.651 7.906c.067.39-.032.717-.221.906l-6.5 6.499a3 3 0 0 0-.878 2.121v2.818c0 .414.336.75.75.75H6a.75.75 0 0 0 .75-.75v-1.5h1.5A.75.75 0 0 0 9 19.5V18h1.5a.75.75 0 0 0 .53-.22l2.658-2.658c.19-.189.517-.288.906-.22A6.75 6.75 0 1 0 15.75 1.5Zm0 3a.75.75 0 0 0 0 1.5A2.25 2.25 0 0 1 18 8.25a.75.75 0 0 0 1.5 0 3.75 3.75 0 0 0-3.75-3.75Z"
              clip-rule="evenodd"
            />
          </svg>

          Sign in with a Passkey
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
import { onMounted, reactive } from 'vue'
import { type BetterFetchOption } from 'better-auth/vue'
import { authClient } from '../lib/auth-client' //import the auth client

const form = reactive({
  email: '',
  password: '',
})

const fetchOptions: BetterFetchOption = {
  onSuccess: () => {
    window.location.href = '/' // Redirect to the home page or dashboard
  },
  onError: (error) => {
    console.error('Error:', error)
    // Handle error (e.g., show error message)
  },
}

onMounted(() => {
  if (
    !PublicKeyCredential.isConditionalMediationAvailable ||
    !PublicKeyCredential.isConditionalMediationAvailable()
  ) {
    return
  }

  authClient.signIn.passkey({ autoFill: true, fetchOptions })
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

async function handleSignInWithPasskey() {
  await authClient.signIn.passkey({
    fetchOptions,
  })
}
</script>
