import { Plus } from "lucide-react-native";
import { useState } from "react";

import { View } from "react-native";

import AddButton from "@/components/add-button";
import Input, { InputProps } from "@/components/input";

interface InputWithButtonProps extends InputProps {
    placeholder: string;
    onSend: () => void;
}

export default function InputWithButton({ placeholder, onSend, ...props }: InputWithButtonProps) {
    const [focused, setFocused] = useState(false);

    return (
        <View className="flex-row items-center gap-2" >
            <Input
                {...props}
                inFocus={focused}
                placeholder={placeholder}
                onFocus={() => setFocused(true)}
                onBlur={() => setFocused(false)}
            />

            <AddButton onPress={onSend} icon={Plus} />
        </View>
    );
}