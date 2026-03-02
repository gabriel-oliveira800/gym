import { z } from "zod";

const schema = z.object({
    id: z.string(),
    name: z.string(),
    createdAt: z.string(),
    updatedAt: z.string(),
});

export type Workout = z.infer<typeof schema>;