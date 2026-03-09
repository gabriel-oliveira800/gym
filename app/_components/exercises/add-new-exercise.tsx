import { Sparkles, X } from 'lucide-react-native';
import React, { useState } from 'react';
import { Modal, ScrollView, Text, View } from 'react-native';

import { useModal } from '@/hooks/useModal';
import { Exercise } from '@/service/data/exercises';
import { Workout } from '@/service/data/workout';
import { repository } from '@/service/repository';

import Button from '@/components/buttons/button';
import IconButton from '@/components/buttons/icon-button';
import VisibleArea from '@/components/customs/visible-area';
import InputLabel from '@/components/inputs/input-label';
import InputDropdown, { InputDropdownItem } from '@/components/inputs/input-with-dropdown';
import InputWithLabel from '@/components/inputs/input-with-label';
import Column from '@/components/spaces/column';
import Row from '@/components/spaces/row';
import ImageGallery, { ImageGalleryItem } from '@/screens/exercises/image-gallery';

interface AddNewExerciseModalProps {
    workouts: Workout[],
    onFinished: (exercise: Exercise) => void,
}

export default function AddNewExerciseModal({ workouts, onFinished }: AddNewExerciseModalProps) {
    const { keys, closeModal } = useModal();

    const [name, setName] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [url, setUrl] = useState<ImageGalleryItem | null>(null);
    const [segment, setSegment] = useState<InputDropdownItem | null>(null);

    const canSave = name !== '' && segment !== null;

    const handleCloseClearAll = () => {
        setName('');
        setSegment(null);
        closeModal('add-exercise');
        setIsLoading(false)
    }


    const handleCreateNewExercise = async () => {
        setIsLoading(true)

        const workoutId = workouts.find((it) => it.id === segment?.value)?.id
        if (!workoutId) return;

        repository.addExercise(name, workoutId, url?.url || null).then((exercise) => {
            handleCloseClearAll()
            onFinished({ ...exercise, workoutId })
        }).finally(() => setIsLoading(false));
    }

    return (
        <Modal
            transparent
            animationType="fade"
            visible={keys.includes('add-exercise')}
        >
            <View className="flex-1 bg-black/90 justify-end">
                <View className="w-full bg-gray-900 border-t border-gray-800 rounded-t-3xl py-6 max-h-[90%]">
                    <ScrollView
                        className='px-4'
                        nestedScrollEnabled
                        showsVerticalScrollIndicator={false}
                    >
                        <View className='flex-row items-center justify-between mb-12'>
                            <View className="flex-row items-start gap-2">
                                <Sparkles size={20} color="#f97316" />
                                <Text className="text-white text-xl font-bold">Novo Exercício</Text>
                            </View>

                            <IconButton
                                icon={<X size={16} color="#fff" />}
                                onPress={handleCloseClearAll}
                            />
                        </View>

                        <View className="gap-5">
                            <InputWithLabel
                                value={name}
                                onChangeText={setName}
                                label='Nome do Exercício'
                                placeholder='Ex: Rosca Martelo'
                            />

                            <InputDropdown
                                label='Segmentos'
                                setValue={setSegment}
                                placeholder='Selecione o segmento'
                                currentValue={segment?.value || ''}
                                items={workouts.map((item) => ({ label: item.name, value: item.id }))}
                            />

                            <VisibleArea
                                visible={segment !== null}
                                placeholder={(
                                    <View className="min-h-64 bg-gray-800/30 p-4 rounded-xl items-center border border-dashed border-gray-800 flex justify-center mb-4">
                                        <Text className="text-gray-600 text-sm text-center">
                                            Selecione um segmento para ver sugestões de fotos.
                                        </Text>
                                    </View>
                                )}
                            >
                                <Column className="mb-2"  >
                                    <InputLabel label={`Sugestões para ${segment?.label}`} />
                                    < ImageGallery
                                        value={url}
                                        onSelected={setUrl}
                                        items={
                                            Array.from({ length: 32 }, (_, i) => ({
                                                id: i,
                                                url: `https://picsum.photos/200/200?random=${i}`,
                                            }))
                                        }
                                    />

                                </Column>
                            </VisibleArea>

                        </View>
                    </ScrollView>
                    <Row className='pt-4 px-4 gap-3 justify-end border-t border-gray-800'>
                        <Button
                            text="Cancelar"
                            onPress={handleCloseClearAll}
                            className='h-14 rounded-md bg-gray-700'
                        />

                        <Button
                            text="Salvar"
                            disabled={!canSave}
                            isLoading={isLoading}
                            onPress={handleCreateNewExercise}
                            className={`h-14 rounded-md ${canSave || isLoading ? "bg-orange-600" : "bg-orange-600 opacity-50"}`}
                        />
                    </Row>
                </View>
            </View>
        </Modal>
    )
}