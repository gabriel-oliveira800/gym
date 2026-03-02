import { relations } from "drizzle-orm";
import { sqliteTable, text } from "drizzle-orm/sqlite-core";

export const workouts = sqliteTable("workouts", {
    id: text("id").primaryKey().notNull(),
    name: text("name").notNull(),
    createdAt: text("created_at").notNull(),
    updatedAt: text("updated_at").notNull(),
});

export const exercises = sqliteTable("exercises", {
    id: text("id").primaryKey().notNull(),
    name: text("name").notNull(),
    workoutId: text("workout_id").notNull().references(
        () => workouts.id, { onDelete: "cascade" }
    ),
    createdAt: text("created_at").notNull(),
    updatedAt: text("updated_at").notNull(),
});

export const workoutsRelations = relations(workouts, ({ many }) => ({
    exercises: many(exercises),
}));

export const exercisesRelations = relations(exercises, ({ one }) => ({
    workout: one(workouts, {
        fields: [exercises.workoutId],
        references: [workouts.id],
    }),
}));