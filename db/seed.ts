import type { ExpoSQLiteDatabase } from "drizzle-orm/expo-sqlite";

import { DEFAULT_WORKOUTS } from "@/constants/values";
import { workouts } from "@/db/schema";
import { repository } from "@/service/repository";

export async function seedIfNeeded(db: ExpoSQLiteDatabase<any>) {
    const now = new Date().toISOString();

    const existing = await db.select().from(workouts);
    const existingNames = new Set(existing.map(w => w.name));

    const toInsert = DEFAULT_WORKOUTS
        .filter(name => !existingNames.has(name))
        .map(name => ({
            name,
            createdAt: now,
            updatedAt: now,
            id: repository.generateId(),
        }));

    if (toInsert.length > 0) {
        await db.insert(workouts).values(toInsert);
    }
}