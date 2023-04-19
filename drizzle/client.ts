import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";

const pool = new Pool({
  connectionString: "postgres://postgres:docker@localhost:5432",
});

export const db = drizzle(pool);
