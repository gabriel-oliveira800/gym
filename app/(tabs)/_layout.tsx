import React from "react";

import { Tabs } from "expo-router";
import { BarChart3, Dumbbell, Home, LayoutGrid } from 'lucide-react-native';
import { useSafeAreaInsets } from "react-native-safe-area-context";

import TabHeader from "@/screens/tabs/tab-header";

export default function Layout() {
  const padding = 16;
  const insets = useSafeAreaInsets();

  return (
    <Tabs
      safeAreaInsets={{
        top: Math.max(insets.top, padding),
        bottom: Math.max(insets.bottom, padding),
        left: Math.max(insets.left, padding),
        right: Math.max(insets.right, padding),
      }}
      screenOptions={{
        headerShown: true,
        header: () => <TabHeader />,
        tabBarActiveTintColor: "#f97316",
        tabBarInactiveTintColor: "#6b7280",
        tabBarStyle: {
          borderTopWidth: 1,
          borderTopColor: "#1f2937",
          backgroundColor: "#111827F2",
        },
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: "Home",
          tabBarIcon: ({ color }) => <Home size={24} color={color} />,
        }}
      />

      <Tabs.Screen
        name="exercises"
        options={{
          title: "Exercícios",
          tabBarIcon: ({ color }) => <Dumbbell size={24} color={color} />,
        }}
      />

      <Tabs.Screen
        name="segments"
        options={{
          title: "Segmentos",
          tabBarIcon: ({ color }) => <LayoutGrid size={24} color={color} />,
        }}
      />

      <Tabs.Screen
        name="stats"
        options={{
          title: "Estatísticas",
          tabBarIcon: ({ color }) => <BarChart3 size={24} color={color} />,
        }}
      />
    </Tabs>
  );
}