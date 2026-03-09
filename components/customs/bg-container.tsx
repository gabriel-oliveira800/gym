import { ReactNode } from "react";
import { View, ViewProps } from "react-native";

interface BgContainerProps extends ViewProps {
    children: ReactNode;
    className?: string;
}

export default function BgContainer({ children, className, ...props }: BgContainerProps) {
    return (
        <View className={`flex-1 bg-[#0F1115] pt-6 px-6 ${className}`} {...props}>
            {children}
        </View>
    );
}