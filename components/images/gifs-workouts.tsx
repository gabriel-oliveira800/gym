import { ExerciseGifEntry, resolveGifGroupData } from "@/constants/normalize-segment-name";
import { Image } from "expo-image";

import { useCallback, useMemo, useState } from "react";
import { ActivityIndicator, Pressable, Text, View } from "react-native";
import { FlatGrid } from "react-native-super-grid";

const PAGE_SIZE = 12;

interface GifWorkoutsProps {
    relativeSegmentName: string;
    onPressExercise?: (item: ExerciseGifEntry) => void;
}

export default function GifsWorkouts({ relativeSegmentName, onPressExercise }: GifWorkoutsProps) {
    const [page, setPage] = useState(1);
    const [isLoadingMore, setIsLoadingMore] = useState(false);

    const allExercises = useMemo<ExerciseGifEntry[]>(
        () => resolveGifGroupData(relativeSegmentName)?.data ?? [],
        [relativeSegmentName],
    );

    const visibleExercises = useMemo(
        () => allExercises.slice(0, page * PAGE_SIZE),
        [allExercises, page],
    );

    const hasMore = visibleExercises.length < allExercises.length;

    const handleEndReached = useCallback(() => {
        if (!hasMore || isLoadingMore) return;
        setIsLoadingMore(true);
        setTimeout(() => {
            setPage((p) => p + 1);
            setIsLoadingMore(false);
        }, 300);
    }, [hasMore, isLoadingMore]);

    if (!relativeSegmentName) return null;
    const test = "../../assets/gifs/abdomen-core/abdominal-bicleta.gif"

    if (allExercises.length === 0) {
        return (
            <View className="flex-1 items-center justify-center py-10">
                <Text className="text-gray-400 text-sm">
                    Nenhum exercício encontrado.
                </Text>
            </View>
        );
    }

    return (
        <FlatGrid
            spacing={0}
            data={visibleExercises}
            keyExtractor={(item) => String(item.id)}
            className="mb-2"
            maxItemsPerRow={3}
            itemDimension={68}
            contentContainerStyle={{ gap: 16 }}
            showsVerticalScrollIndicator={false}
            onEndReachedThreshold={0.8}
            onEndReached={handleEndReached}
            ListFooterComponent={
                isLoadingMore ? (
                    <View className="py-4 items-center">
                        <ActivityIndicator size="small" />
                    </View>
                ) : null
            }
            renderItem={({ item }: { item: ExerciseGifEntry }) => (
                <Pressable
                    onPress={() => onPressExercise?.(item)}
                    className="w-full h-24 bg-gray-800 p-2 rounded-md flex flex-row justify-between items-center border border-gray-700"
                >
                    {/* <Text>{item.path}</Text> */}
                    <Image
                        style={{ width: 96, height: 96 }}
                        source={{ uri: require(test) }}
                        // source={require("../../assets/gifs/abdomen-core/abdominal-bicleta.gif")}
                        // source={IMAGE_REGISTRY[item.path]}
                        contentFit="cover"
                    />
                </Pressable>
            )}
        />
    );
}