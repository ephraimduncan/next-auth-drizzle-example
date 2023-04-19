import type { Adapter } from "next-auth/adapters";
import { NodePgDatabase } from "drizzle-orm/node-postgres";
import { User } from "../drizzle/schema";
import { InferModel } from "drizzle-orm";

export type NewUser = InferModel<typeof User, "insert">;

export default function DrizzleAdapter(db: NodePgDatabase) {
  return {
    async createUser(user: NewUser) {
      const insertedUsers = await db.insert(User).values(user).returning();

      return insertedUsers[0];
    },
  };
}
