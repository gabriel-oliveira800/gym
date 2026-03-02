import { z } from "zod";

const schema = z.object({
    id: z.string(),
    name: z.string(),
    workoutId: z.string(),
    createdAt: z.string(),
    updatedAt: z.string(),
});

export type Exercise = z.infer<typeof schema>;