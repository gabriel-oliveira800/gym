import { ActivityIndicator, Pressable, PressableProps, Text } from "react-native";
import VisibleArea from "../customs/visible-area";

interface ButtonProps extends PressableProps {
    text?: string | null;
    children?: React.ReactNode;
    isLoading?: boolean
}

function Button({ children, className, text, isLoading = false, ...props }: ButtonProps) {
    return (
        <Pressable className={`flex-1 items-center justify-center py-3 bg-orange-600 rounded-2xl ${className}`} {...props}>
            <VisibleArea visible={!!text}>
                {
                    isLoading ?
                        (
                            <ActivityIndicator color="white" size="small" />
                        ) :
                        (
                            <Text className="text-white font-bold">{text}</Text>
                        )
                }
            </VisibleArea>
            {children}
        </Pressable>
    );
}

export default Button;