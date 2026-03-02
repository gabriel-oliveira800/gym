import { Trash2 } from "lucide-react-native";
import { Pressable, PressableProps, Text } from "react-native";

import { Workout } from "@/service/data/workout";

import AddButton from "./add-button";

interface WorkoutItemProps extends PressableProps {
    workout: Workout;
    onRemove: (workout: Workout) => void;
}

export default function WorkoutItem({ workout, onRemove, className, ...props }: WorkoutItemProps) {
    return (
        <Pressable className={`bg-gray-800 p-4 rounded-2xl flex flex-row justify-between items-center border border-gray-700 ${className}`} {...props} onPress={() => onRemove(workout)}>
            <Text className='text-gray-200 font-bold text-sm tracking-wide'>{workout.name}</Text>
            <AddButton className='w-8 h-8' onPress={() => onRemove(workout)} icon={Trash2} />
        </Pressable>
    );
}