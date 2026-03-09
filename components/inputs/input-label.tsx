import { Text } from "react-native";

export default function InputLabel({ label }: { label: string }) {
    return (
        <Text className="text-gray-500 text-[10px] font-bold uppercase mb-4 ml-1 tracking-widest">
            {label}
        </Text>
    )
}