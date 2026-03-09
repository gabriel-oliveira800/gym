import { Pressable, PressableProps } from "react-native";


interface IconButtonProps extends PressableProps {
    icon?: React.ReactNode
    children?: React.ReactNode
}

function IconButton({ icon, children, ...props }: IconButtonProps) {
    return (
        <Pressable
            className="w-8 h-8 flex items-center justify-center rounded-full bg-gray-800 border border-gray-700 cursor-pointer"
            {...props}
        >
            {icon}
            {children}
        </Pressable>
    );
}

export default IconButton;