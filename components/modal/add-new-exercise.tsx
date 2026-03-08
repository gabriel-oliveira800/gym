import { Picker } from '@react-native-picker/picker';
import { CheckCircle2, Sparkles, X } from 'lucide-react-native';
import React from 'react';
import { Image, Modal, Pressable, ScrollView, Text, TextInput, View } from 'react-native';

import { useModal } from '@/hooks/useModal';

type NewEx = {
    name: string;
    segment: string;
    urlImage: string;
};

export default function AddNewExerciseModal(
    {
        onClose,
        onSave,
        segments,
        newEx,
        setNewEx,
        SEGMENT_SUGGESTIONS,
        handleSelectSuggestion,
    }: {
        onClose: () => void;
        onSave: () => void;
        segments: string[];
        newEx: NewEx;
        setNewEx: (v: NewEx) => void;
        SEGMENT_SUGGESTIONS: Record<string, string[]>;
        handleSelectSuggestion: (id: string) => void;
    }
) {
    const { keys, closeModal } = useModal();
    const canSave = !!newEx.name && !!newEx.segment;

    return (
        <Modal
            transparent
            animationType="fade"
            visible={keys.includes('add-exercise')}
        >
            <View className="absolute inset-0 bg-black/95 justify-center items-center px-6">
                {/* Blur opcional (descomente se usar expo-blur)
        <BlurView intensity={25} tint="dark" className="absolute inset-0" />
        */}

                <View className="w-full max-w-sm bg-gray-900 border border-gray-800 rounded-3xl p-6 max-h-[90%]">
                    <ScrollView showsVerticalScrollIndicator={false}>
                        <View className="flex-row items-center gap-2 mb-6">
                            <Sparkles size={20} color="#f97316" />
                            <Text className="text-white text-xl font-bold">Novo Exercício</Text>
                        </View>

                        <View className="gap-5">
                            <View>
                                <Text className="text-gray-500 text-[10px] font-bold uppercase mb-1.5 ml-1 tracking-widest">
                                    Informações Básicas
                                </Text>

                                <TextInput
                                    value={newEx.name}
                                    onChangeText={(text) => setNewEx({ ...newEx, name: text })}
                                    placeholder="Nome (ex: Rosca Martelo)"
                                    placeholderTextColor="#4b5563"
                                    className="min-h-16 w-full bg-gray-800 rounded-xl px-4 py-3.5 text-white mb-2"
                                />

                                <View className="h-16 w-full px-2 bg-gray-800 rounded-xl overflow-hidden">
                                    <Picker
                                        selectedValue={newEx.segment}
                                        onValueChange={(value) => setNewEx({ ...newEx, segment: String(value) })}
                                        dropdownIconColor="#9ca3af"
                                        style={{ color: "white" }}
                                    >
                                        <Picker.Item label="Selecione o Segmento" value="" />
                                        {segments.map((s) => (
                                            <Picker.Item key={s} label={s} value={s} />
                                        ))}
                                    </Picker>
                                </View>
                            </View>

                            <View>
                                <Text className="text-gray-500 text-[10px] font-bold uppercase mb-1.5 ml-1 tracking-widest">
                                    Imagem do Exercício
                                </Text>

                                <View className="relative mb-3">
                                    <TextInput
                                        value={newEx.urlImage}
                                        onChangeText={(text) => setNewEx({ ...newEx, urlImage: text })}
                                        placeholder="Cole uma URL ou use as sugestões"
                                        placeholderTextColor="#4b5563"
                                        className="min-h-16 w-full bg-gray-800 rounded-xl px-4 py-3.5 text-white text-xs pr-10"
                                        numberOfLines={1}
                                    />

                                    {!!newEx.urlImage && (
                                        <Pressable
                                            onPress={() => setNewEx({ ...newEx, urlImage: "" })}
                                            className="absolute right-3 top-1/2 -translate-y-1/2"
                                            hitSlop={10}
                                        >
                                            <X size={14} color="#6b7280" />
                                        </Pressable>
                                    )}
                                </View>

                                {newEx.segment && SEGMENT_SUGGESTIONS[newEx.segment] ? (
                                    <View>
                                        <Text className="text-orange-500 text-[10px] font-bold uppercase mb-2 ml-1">
                                            Sugestões para {newEx.segment}
                                        </Text>

                                        <View className="flex-row flex-wrap gap-2">
                                            {SEGMENT_SUGGESTIONS[newEx.segment].map((id) => {
                                                const selected = newEx.urlImage?.includes(id);

                                                return (
                                                    <Pressable
                                                        key={id}
                                                        onPress={() => handleSelectSuggestion(id)}
                                                        className={[
                                                            "w-[23%] aspect-square rounded-lg overflow-hidden border-2",
                                                            selected
                                                                ? "border-orange-500"
                                                                : "border-transparent opacity-60",
                                                        ].join(" ")}
                                                    >
                                                        <Image
                                                            source={{ uri: `https://images.unsplash.com/photo-${id}?w=200&h=200&fit=crop` }}
                                                            className="w-full h-full"
                                                            resizeMode="cover"
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
                                    </View>
                                ) : (
                                    <View className="bg-gray-800/30 p-4 rounded-xl items-center border border-dashed border-gray-800">
                                        <Text className="text-gray-600 text-[10px] text-center">
                                            Selecione um segmento para ver sugestões de fotos.
                                        </Text>
                                    </View>
                                )}
                            </View>

                            <View className="flex-row gap-3 pt-4">
                                <Pressable onPress={onClose} className="flex-1 py-3">
                                    <Text className="text-gray-500 font-bold text-center">Cancelar</Text>
                                </Pressable>

                                <Pressable
                                    onPress={onSave}
                                    disabled={!canSave}
                                    className={[
                                        "flex-1 py-3 rounded-2xl items-center justify-center",
                                        canSave ? "bg-orange-600" : "bg-orange-600 opacity-50",
                                    ].join(" ")}
                                >
                                    <Text className="text-white font-bold">Salvar</Text>
                                </Pressable>
                            </View>
                        </View>
                    </ScrollView>
                </View>
            </View>
        </Modal>
    )
}