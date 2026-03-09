import { View, ViewProps } from "react-native";

interface VisibleAreaProps extends ViewProps {
    visible: boolean;
    children: React.ReactNode;
    placeholder?: React.ReactNode;
}

function VisibleArea({ visible, children, placeholder, ...props }: VisibleAreaProps) {
    return (
        <View {...props}>
            {!visible && placeholder}
            {visible && children}
        </View>
    );
}

export default VisibleArea;