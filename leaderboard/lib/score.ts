import { db } from "@/db";
import { scores } from "@/db/schema";
import { desc, gte } from "drizzle-orm";

function startOfDay(date: Date) {
  return new Date(date.getFullYear(), date.getMonth(), date.getDate());
}

export async function getDailyScores() {
  return db
    .select()
    .from(scores)
    .where(gte(scores.date, startOfDay(new Date())))
    .orderBy(desc(scores.score))
    .limit(10)
    .all();
}

export async function addScore(score: number, name: string) {
  await db.insert(scores).values({ score, name, date: new Date() }).run();
}
