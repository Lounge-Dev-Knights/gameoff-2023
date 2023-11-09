import { index, integer, sqliteTable, text } from "drizzle-orm/sqlite-core";

export const scores = sqliteTable(
  "scores",
  {
    id: integer("id").primaryKey(),
    name: text("name").notNull(),
    score: integer("score").notNull(),
    date: integer("date", { mode: "timestamp" })
      .notNull()
      .$defaultFn(() => new Date()),
  },
  (table) => {
    return {
      scoreIdx: index("score_idx").on(table.score),
      dateIdx: index("date_idx").on(table.date),
    };
  },
);
