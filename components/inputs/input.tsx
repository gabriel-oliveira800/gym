import { useState } from "react";
import { TextInput, TextInputProps } from "react-native";

export interface InputProps extends TextInputProps {
    placeholder: string;
}

export default function Input({ ...props }: InputProps) {
    const [focused, setFocused] = useState(false);

    return (
        <TextInput
            className={`h-16 flex-1 bg-gray-800 text-white border border-gray-700 rounded-xl px-4 py-3 text-base ${focused ? "border-orange-600" : "border-gray-700"}`}
            placeholderTextColor="#6b7280"
            onFocus={() => setFocused(true)}
            onBlur={() => setFocused(false)}
            {...props}
        />
    );
}