import { LayoutGrid } from 'lucide-react-native';
import { useEffect, useState } from 'react';
import { ActivityIndicator, Alert } from 'react-native';
import { FlatGrid } from 'react-native-super-grid';

import { Workout } from '@/service/data/workout';
import { repository } from '@/service/repository';

import BgContainer from '@/components/bg-container';
import Header from '@/components/header';
import InputWithButton from '@/components/input-with-button';
import WorkoutItem from '@/components/workout-item';

export default function SegmentsScreen() {
    const [name, setName] = useState('');
    const [loading, setLoading] = useState(true);
    const [workouts, setWorkouts] = useState<Workout[]>([]);

    async function handleAddWorkout() {
        if (name.trim() === '') {
            return Alert.alert('Nome inválido', 'O nome do segmento não pode ser vazio');
        }

        const id = repository.generateId();
        repository.addWorkout(id, name).then((workout) => {
            setName('');
            setWorkouts((prev) => [...prev, workout]);
        });
    }

    async function handleRemoveWorkout(workout: Workout) {
        repository.removeWorkout(workout.id).then(() => {
            setWorkouts((prev) => prev.filter((w) => w.id !== workout.id));
        });
    }

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
        <BgContainer className='gap-6'>
            <Header title='Segmentos' Icon={LayoutGrid} />
            <InputWithButton
                onSend={handleAddWorkout}
                placeholder='Nome do segmento'
                value={name} onChangeText={setName}
            />

            <FlatGrid
                spacing={0}
                data={workouts}
                className='mb-2'
                maxItemsPerRow={2}
                itemDimension={130}
                contentContainerStyle={{ gap: 12 }}
                showsVerticalScrollIndicator={false}
                renderItem={({ item }) => (
                    <WorkoutItem
                        key={item.id}
                        workout={item}
                        className='mr-2 '
                        onRemove={handleRemoveWorkout}
                    />
                )}
            />
        </BgContainer >
    );
}
