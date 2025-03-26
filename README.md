# Astro Passkeys with Better Auth

This is an **example project** that demonstrates how to implement secure authentication with Passkeys in an Astro application using the Better Auth library.

## 🔐 Features

- Email/password authentication
- Passkey authentication with WebAuthn
- User registration and sign-in pages
- Session management
- Protected routes

## 🚀 Project Structure

```text
/
├── public/
│   └── favicon.svg
├── src/
│   ├── components/
│   │   ├── SignIn.vue      # Login form with Passkey support
│   │   └── SignUp.vue      # Registration form
│   ├── layouts/
│   │   └── Layout.astro    # Main layout component
│   ├── lib/
│   │   ├── auth.ts         # Server-side auth setup
│   │   └── auth-client.ts  # Client-side auth setup
│   └── pages/
│       ├── api/auth/[...all].ts  # Auth API routes
│       ├── index.astro     # Protected homepage
│       ├── sign-in.astro   # Login page
│       └── sign-up.astro   # Registration page
└── package.json
```

## 🔧 Setup

1. Clone this repository
2. Install dependencies:
   ```sh
   bun install
   ```
3. Copy `.env.example` to `.env` and set your variables:
   ```sh
   cp .env.example .env
   ```
4. Start the development server:
   ```sh
   bun run dev
   ```

## 💡 How It Works

This example demonstrates:

- Setting up Better Auth with SQLite database
- Configuring Passkey authentication
- Building responsive sign-in/sign-up forms with Vue components
- Protecting routes with authentication checks
- Managing user sessions
- Adding passkeys to user accounts

## 🧞 Commands

All commands are run from the root of the project:

| Command           | Action                                       |
| :---------------- | :------------------------------------------- |
| `bun install`     | Installs dependencies                        |
| `bun run dev`     | Starts local dev server at `localhost:4321`  |
| `bun run build`   | Build your production site to `./dist/`      |
| `bun run preview` | Preview your build locally, before deploying |

## 📚 Learn More

- [Better Auth Documentation](https://www.better-auth.com/)
- [WebAuthn & Passkeys](https://webauthn.guide/)
- [Astro Documentation](https://docs.astro.build)
