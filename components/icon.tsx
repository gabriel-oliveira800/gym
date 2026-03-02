// Fallback for using MaterialIcons on Android and web.

import MaterialIcons from '@expo/vector-icons/MaterialIcons';
import { SymbolWeight } from 'expo-symbols';
import { OpaqueColorValue, type StyleProp, type TextStyle } from 'react-native';

type IconSymbolName = keyof typeof MaterialIcons.glyphMap;

interface IconProps {
  name: IconSymbolName;
  size?: number;
  color: string | OpaqueColorValue;
  style?: StyleProp<TextStyle>;
  weight?: SymbolWeight;
}

export function Icon({
  name,
  color,
  style,
  size = 24,
}: IconProps) {
  return <MaterialIcons color={color} size={size} name={name} style={style} />;
}
