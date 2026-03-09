import { View, ViewProps } from "react-native";

interface RowProps extends ViewProps {
    children: React.ReactNode;
}

function Row({ children, className, ...props }: RowProps) {
    return (
        <View className={`flex-row ${className}`} {...props}>
            {children}
        </View>
    );
}

export default Row;