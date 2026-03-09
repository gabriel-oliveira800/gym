import { asc, eq, InferInsertModel, InferSelectModel } from "drizzle-orm";

import { sqlDb } from "@/db/db";
import { workouts } from "@/db/schema";

import { Workout } from "@/service/data/workout";

export type WorkoutRow = InferSelectModel<typeof workouts>;
export type WorkoutInsert = InferInsertModel<typeof workouts>;

class Repository {
    constructor() { }

    generateId() {
        return Math.random().toString(30).substring(2, 20);
    }

    async getWorkouts(): Promise<Workout[]> {
        const raw = await sqlDb.select().from(workouts).orderBy(asc(workouts.name));
        return raw.map((workout) => ({
            id: workout.id,
            name: workout.name,
            createdAt: workout.createdAt,
            updatedAt: workout.updatedAt,
        } as Workout));
    }

    async addWorkout(name: string): Promise<Workout> {
        const now = new Date().toISOString();
        const newWorkout = await sqlDb.insert(workouts).values({
            name: name,
            createdAt: now,
            updatedAt: now,
            id: this.generateId(),
        }).returning();

        return newWorkout[0];
    }

    async removeWorkout(id: string): Promise<boolean> {
        const result = await sqlDb.delete(workouts).where(eq(workouts.id, id));

        return result.changes === 1;
    }

    async addExercise(name: string, workoutId: string, url: string | null): Promise<Workout> {
        const now = new Date().toISOString();
        const newWorkout = await sqlDb.insert(workouts).values({
            name: name,
            createdAt: now,
            updatedAt: now,
            id: this.generateId(),
        }).returning();

        return newWorkout[0];
    }
}

const repository = new Repository();
export { repository };

