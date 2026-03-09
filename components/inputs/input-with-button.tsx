import { Plus } from "lucide-react-native";

import { View } from "react-native";

import AddButton from "@/components/buttons/add-button";
import Input, { InputProps } from "@/components/inputs/input";

interface InputWithButtonProps extends InputProps {
    placeholder: string;
    onSend: () => void;
}

export default function InputWithButton({ placeholder, onSend, ...props }: InputWithButtonProps) {


    return (
        <View className="flex-row items-center gap-2" >
            <Input
                {...props}
                placeholder={placeholder}
            />

            <AddButton onPress={onSend} icon={Plus} />
        </View>
    );
}