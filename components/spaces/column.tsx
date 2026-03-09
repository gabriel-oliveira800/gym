import { View, ViewProps } from "react-native";

interface ColumnProps extends ViewProps {
    children: React.ReactNode;
}

export default function Column({ children, className, ...props }: ColumnProps) {
    return (
        <View className={`flex-col ${className}`} {...props}>
            {children}
        </View>
    );
}