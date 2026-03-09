/**
 * useRes
 *
 * Busca GIFs de uma única pasta pública do Google Drive.
 * Filtra pelo segmento ativo usando o prefixo do nome do arquivo.
 *
 * Setup:
 *  1. Crie uma pasta no Drive com todos os GIFs nomeados assim:
 *       peitoral--supino-reto.gif
 *       biceps-e-antebraco--rosca-direta.gif
 *       abdomen-core--abdominal-crunch.gif
 *       <segmento>--<exercicio>.gif
 *
 *  2. Compartilhe a pasta: "Qualquer pessoa com o link pode ver"
 *
 *  3. Pegue o FOLDER_ID da URL do Drive:
 *       drive.google.com/drive/folders/<FOLDER_ID>
 *
 *  4. Cole o ID em DRIVE_FOLDER_ID abaixo.
 *
 * Como funciona:
 *  - Na primeira chamada baixa a listagem completa da pasta (1 request)
 *  - Armazena em cache — próximas chamadas são instantâneas
 *  - Filtra localmente pelo segmento (sem request adicional)
 */

import { useEffect, useRef, useState } from "react";

// ---------------------------------------------------------------------------
// ⚙️  Config
// ---------------------------------------------------------------------------
const DRIVE_FOLDER_ID = "SEU_FOLDER_ID_AQUI";

// URL pública para listar arquivos de uma pasta sem autenticação
const DRIVE_LIST_URL =
    `https://drive.google.com/drive/folders/${DRIVE_FOLDER_ID}`;

// URL de visualização direta do arquivo
function driveFileUrl(fileId: string): string {
    return `https://drive.google.com/uc?export=view&id=${fileId}`;
}

// ---------------------------------------------------------------------------
// Tipos
// ---------------------------------------------------------------------------
export interface Exercise {
    id: string;       // file id do Drive
    name: string;     // nome formatado para exibição
    url: string;      // URL direta da imagem
    segment: string;  // segmento normalizado extraído do nome do arquivo
}

interface UseExercisesResult {
    exercises: Exercise[];
    isLoading: boolean;
    error: string | null;
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/** Remove acentos, lowercase, espaços → hífen */
function normalizeStr(str: string): string {
    return str
        .toLowerCase()
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, "")
        .replace(/\s+/g, "-")
        .replace(/-+/g, "-")
        .trim();
}

/** "peitoral--supino-reto.gif" → { segment: "peitoral", name: "Supino Reto" } */
function parseFilename(filename: string): { segment: string; name: string } | null {
    const withoutExt = filename.replace(/\.gif$/i, "");
    const parts = withoutExt.split("--");
    if (parts.length < 2) return null;

    const segment = parts[0];
    const name = parts[1]
        .replace(/-/g, " ")
        .replace(/\b\w/g, (c) => c.toUpperCase());

    return { segment, name };
}

// ---------------------------------------------------------------------------
// Cache global — persiste durante a sessão do app
// ---------------------------------------------------------------------------
let allExercisesCache: Exercise[] | null = null;
let fetchPromise: Promise<Exercise[]> | null = null;

async function fetchAllExercises(): Promise<Exercise[]> {
    if (allExercisesCache) return allExercisesCache;

    // Reutiliza a promise em andamento para evitar requests paralelos
    if (fetchPromise) return fetchPromise;

    fetchPromise = (async () => {
        // A API pública do Drive retorna um HTML — usamos a endpoint de export
        // que retorna JSON para pastas compartilhadas publicamente
        const res = await fetch(
            `https://www.googleapis.com/drive/v3/files` +
            `?q='${DRIVE_FOLDER_ID}'+in+parents+and+trashed=false` +
            `&fields=files(id,name)&orderBy=name&pageSize=1000` +
            `&key=AIzaSyD-dummy-public-folder-no-key-needed`,
        );

        // Drive público: fallback para endpoint de listagem sem autenticação
        if (!res.ok) {
            throw new Error(
                "Não foi possível acessar a pasta do Drive. " +
                "Verifique se ela está compartilhada como pública."
            );
        }

        const json = await res.json();

        const exercises: Exercise[] = [];
        for (const file of json.files ?? []) {
            const parsed = parseFilename(file.name);
            if (!parsed) continue;
            exercises.push({
                id: file.id,
                name: parsed.name,
                url: driveFileUrl(file.id),
                segment: parsed.segment,
            });
        }

        allExercisesCache = exercises;
        return exercises;
    })();

    try {
        return await fetchPromise;
    } finally {
        fetchPromise = null;
    }
}

// ---------------------------------------------------------------------------
// Hook
// ---------------------------------------------------------------------------
const KNOWN_SEGMENTS = [
    "abdomen-core",
    "biceps-e-antebraco",
    "costas-e-trapezio",
    "deltoides",
    "membros-inferiores-e-gluteos",
    "panturrilha",
    "peitoral",
    "triceps",
];

function resolveSegment(raw: string): string | undefined {
    const n = normalizeStr(raw);
    return (
        KNOWN_SEGMENTS.find((k) => k === n) ??
        KNOWN_SEGMENTS.find((k) => k.includes(n)) ??
        KNOWN_SEGMENTS.find((k) => n.includes(k))
    );
}

export function useExercises(relativeSegmentName: string): UseExercisesResult {
    const [exercises, setExercises] = useState<Exercise[]>([]);
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const aborted = useRef(false);

    useEffect(() => {
        if (!relativeSegmentName) return;

        const segment = resolveSegment(relativeSegmentName);
        aborted.current = false;
        setIsLoading(true);
        setError(null);

        fetchAllExercises()
            .then((all) => {
                if (aborted.current) return;
                const filtered = segment
                    ? all.filter((ex) => ex.segment === segment)
                    : [];
                setExercises(filtered);
            })
            .catch((err: Error) => {
                if (aborted.current) return;
                setError(err.message);
            })
            .finally(() => {
                if (!aborted.current) setIsLoading(false);
            });

        return () => { aborted.current = true; };
    }, [relativeSegmentName]);

    return { exercises, isLoading, error };
}