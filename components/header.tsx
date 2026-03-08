import React from "react";

import { LucideIcon } from 'lucide-react-native';
import { Text, View } from "react-native";

interface HeaderProps {
  title: string;
  Icon?: LucideIcon;
  children?: React.ReactNode;
}

export default function Header({ title, Icon, children }: HeaderProps) {
  return (
    <View className="flex justify-between flex-row items-center" >
      <Text className="text-white text-xl font-bold italic uppercase">
        {title}
      </Text>

      {Icon && <Icon size={24} color="#f97316" />}

      {children}
    </View>
  );
}


