// @ts-check
import { defineConfig } from 'astro/config'

import vue from '@astrojs/vue'
import tailwindcss from '@tailwindcss/vite'

import node from '@astrojs/node'

// https://astro.build/config
export default defineConfig({
  output: 'server',

  integrations: [vue()],

  vite: {
    plugins: [tailwindcss()],
  },

  adapter: node({
    mode: 'standalone',
  }),
})
