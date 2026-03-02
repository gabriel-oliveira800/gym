import { drizzle } from "drizzle-orm/expo-sqlite";
import { migrate } from "drizzle-orm/expo-sqlite/migrator";
import { openDatabaseSync } from "expo-sqlite";

import { seedIfNeeded } from "@/db/seed";
import migrations from "@/drizzle/migrations";

export const DB_NAME = "gym-app.db";
const expoDb = openDatabaseSync(DB_NAME);
const sqlDb = drizzle(expoDb);

async function initDb() {
    await migrate(sqlDb, migrations);
    await seedIfNeeded(sqlDb);
}

export { initDb, sqlDb };

