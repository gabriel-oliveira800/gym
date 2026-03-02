import { TextInput, TextInputProps } from "react-native";

export interface InputProps extends TextInputProps {
    placeholder: string;
    inFocus?: boolean;
}

export default function Input({ inFocus, ...props }: InputProps) {
    return (
        <TextInput
            style={{
                fontSize: 16,
                borderColor: inFocus ? "#f97316" : "#374151"
            }}
            className="min-h-16 flex-1 bg-gray-800 text-white border border-gray-700 rounded-xl px-4 py-3" {...props}
            placeholderTextColor="#6b7280"
        />
    );
}