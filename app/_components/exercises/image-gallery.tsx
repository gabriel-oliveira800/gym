import { CheckCircle2 } from 'lucide-react-native';
import React from 'react';
import { Image, Pressable, View } from 'react-native';

export interface ImageGalleryItem {
    id: string | number
    url: string
}

interface ImageGalleryProps {
    items: ImageGalleryItem[]
    value: ImageGalleryItem | null
    onSelected: (item: ImageGalleryItem) => void
}

export default function ImageGallery({ items, value, onSelected }: ImageGalleryProps) {
    return (
        <View className="min-h-64 bg-gray-800/30 p-4 rounded-xl items-center border border-dashed border-gray-800 flex justify-center mb-4 flex-row flex-wrap gap-2">
            {items.map((item) => {
                const selected = value !== null && item.id === value.id;

                return (
                    <Pressable
                        key={item.id}
                        onPress={() => onSelected(item)}
                        className={[
                            "w-[23%] aspect-square rounded-lg overflow-hidden border-2",
                            selected
                                ? "border-orange-500"
                                : "border-transparent opacity-60",
                        ].join(" ")}
                    >
                        <Image
                            resizeMode="cover"
                            className="w-full h-full"
                            source={{ uri: item.url }}
                        />

                        {selected && (
                            <View className="absolute inset-0 bg-orange-500/20 items-center justify-center">
                                <CheckCircle2 size={16} color="#ffffff" />
                            </View>
                        )}
                    </Pressable>
                );
            })}
        </View>
    );
}