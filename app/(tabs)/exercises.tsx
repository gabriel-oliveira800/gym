import { Plus } from 'lucide-react-native';
import { useState } from 'react';
import { ActivityIndicator } from 'react-native';

import { useModal } from '@/hooks/useModal';

import AddButton from '@/components/add-button';
import BgContainer from '@/components/bg-container';
import Header from '@/components/header';
import AddNewExerciseModal from '@/components/modal/add-new-exercise';

export default function ExercisesScreen() {
    const { keys, closeModal, openModal } = useModal();
    const [loading, setLoading] = useState(false);

    if (loading) {
        return (
            <BgContainer className="absolute inset-0 justify-center items-center">
                <ActivityIndicator size="large" color="#f97316" />
            </BgContainer>
        );
    }

    return (
        <BgContainer>
            <Header title='EXERCÍCIOS'>
                <AddButton
                    className='w-12 h-12 bg-orange-600 text-white p-3 rounded-full justify-center items-center'
                    icon={Plus}
                    iconSize={24}
                    onPress={() => openModal('add-exercise')}
                />
            </Header>

            <AddNewExerciseModal
                onClose={() => closeModal('add-exercise')}
                onSave={() => { }}
                segments={[]}
                newEx={{ name: '', segment: '', urlImage: '' }}
                setNewEx={() => { }}
                SEGMENT_SUGGESTIONS={{}}
                handleSelectSuggestion={() => { }}
            />
        </BgContainer>
    );
}
