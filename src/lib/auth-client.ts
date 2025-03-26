import { createAuthClient } from 'better-auth/vue'
import { passkeyClient } from 'better-auth/client/plugins'

export const authClient = createAuthClient({
  plugins: [passkeyClient()],
})
