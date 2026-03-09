import abdomenData from "@/assets/gifs/abdomen-core/index.json";
import bicepsData from "@/assets/gifs/biceps-e-antebraco/index.json";
import costasData from "@/assets/gifs/costas-e-trapezio/index.json";
import deltoidesData from "@/assets/gifs/deltoides/index.json";
import membrosData from "@/assets/gifs/membros-inferiores-e-gluteos/index.json";
import panturrilhaData from "@/assets/gifs/panturrilha/index.json";
import peitoralData from "@/assets/gifs/peitoral/index.json";
import tricepsData from "@/assets/gifs/triceps/index.json";
import { normalizeStr } from "./helpers";

export type ExerciseGifEntry = { id: number; name: string; path: string };
export type GifGroupData = { data: ExerciseGifEntry[] };

const GROUP_MAP: Record<string, GifGroupData> = {
    "abdomen-core": abdomenData,
    "biceps-e-antebraco": bicepsData,
    "costas-e-trapezio": costasData,
    "deltoides": deltoidesData,
    "membros-inferiores-e-gluteos": membrosData,
    "panturrilha": panturrilhaData,
    "peitoral": peitoralData,
    "triceps": tricepsData,
};

const GROUP_KEYS = Object.keys(GROUP_MAP);

/**
 * Busca relativa — tenta em ordem crescente de permissividade:
 *  1. match exato após normalizar          "biceps-e-antebraco" → ✅
 *  2. chave contém o input                 "peito"    → "peitoral"
 *  3. input contém a chave                 "triceps completo" → "triceps"
 */
export function resolveGifGroupData(raw: string): GifGroupData | undefined {
    const normalized = normalizeStr(raw);

    return (
        GROUP_MAP[normalized] ??
        GROUP_MAP[GROUP_KEYS.find((k) => k.includes(normalized)) ?? ""] ??
        GROUP_MAP[GROUP_KEYS.find((k) => normalized.includes(k)) ?? ""]
    );
}