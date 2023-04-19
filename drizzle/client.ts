import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";

const pool = new Pool({
  connectionString: "postgres://postgres:postgres@localhost:5432",
});

export const db = drizzle(pool);
