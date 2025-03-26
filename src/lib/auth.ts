import { betterAuth } from 'better-auth'
import { passkey } from 'better-auth/plugins/passkey'
import Database from 'better-sqlite3'

export const auth = betterAuth({
  database: new Database('./sqlite.db'),
  emailAndPassword: {
    enabled: true,
  },
  plugins: [passkey()],
})
