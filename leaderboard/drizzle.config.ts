import type { Config } from "drizzle-kit";

import { loadEnvConfig } from "@next/env";

loadEnvConfig(process.cwd());

export default {
  schema: "db/schema.ts",
  driver: "turso",
  out: "./drizzle",
  dbCredentials: {
    url: process.env.DATABASE_URL!,
    authToken: process.env.DATABASE_AUTH_TOKEN!,
  },
} satisfies Config;
