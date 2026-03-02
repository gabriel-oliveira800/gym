import { Pressable, PressableProps } from "react-native";

export type ButtonIconProps = { size: number; color: string };

interface ButtonProps extends PressableProps {
  icon: React.ComponentType<ButtonIconProps>;
}

export default function AddButton({ onPress, icon: Icon, ...props }: ButtonProps) {
  return (
    <Pressable
      onPress={onPress}
      className="min-h-16 w-16 bg-orange-600 text-white p-3 rounded-xl justify-center items-center"
      {...props}
    >
      <Icon size={20} color="#ffffff" />
    </Pressable>
  );
}