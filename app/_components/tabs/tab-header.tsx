import { Dumbbell } from 'lucide-react-native';
import { Image, Text, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";

import React from "react";

export default function TabHeader() {
  return (
    <SafeAreaView
      edges={['top']}
      className="sticky top-0 z-40 bg-[#0F1115] backdrop-blur-md border-b border-gray-800 px-6 py-4 flex flex-row justify-between items-center"
    >
      <View className="flex flex-row gap-2">
        <View className="bg-orange-600 p-1.5 rounded-lg shadow-lg shadow-orange-600/20">
          <Dumbbell size={24} color="#fff" />
        </View>

        <View className="flex flex-row items-center justify-center">
          <Text className="text-xl font-black italic tracking-tighter uppercase text-white">
            ORANGE
          </Text>
          <Text className="text-xl font-black italic tracking-tighter uppercase text-orange-500">
            FIT
          </Text>
        </View>
      </View>

      <Image className="w-10 h-10 rounded-full bg-gray-800 border-2 border-orange-500/30 overflow-hidden" source={{ uri: "https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" }} />

    </SafeAreaView>
  );
}


