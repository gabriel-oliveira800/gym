import { Plus } from 'lucide-react-native';
import { useEffect, useState } from 'react';
import { ActivityIndicator, Text, View } from 'react-native';

import { useModal } from '@/hooks/useModal';
import { Exercise } from '@/service/data/exercises';
import { Workout } from '@/service/data/workout';
import { repository } from '@/service/repository';

import AddNewExerciseModal from '@/screens/exercises/add-new-exercise';

import AddButton from '@/components/buttons/add-button';
import BgContainer from '@/components/customs/bg-container';
import Header from '@/components/customs/header';

export default function ExercisesScreen() {
    const { openModal } = useModal();
    const [loading, setLoading] = useState(false);
    const [workouts, setWorkouts] = useState<Workout[]>([]);
    const [exercises, setExercises] = useState<Exercise[]>([]);

    useEffect(() => {
        const loadWorkouts = async () => {
            const workouts = await repository.getWorkouts();
            setWorkouts(workouts);
            setLoading(false);
        };
        loadWorkouts();

        return () => { loadWorkouts(); };
    }, []);

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
                workouts={workouts}
                onFinished={(exercise) => setExercises((prev) => [...prev, exercise])}
            />

            <View className="gap-3 my-8">
                {exercises.map((exercise) => (
                    <View
                        key={exercise.id}
                        className="bg-gray-800 p-4 rounded-xl"
                    >
                        <Text className="text-white font-bold">
                            {exercise.name}
                        </Text>

                        <Text className="text-gray-400">
                            {exercise.workoutId}
                        </Text>
                    </View>
                ))}
            </View>



        </BgContainer>
    );
}
