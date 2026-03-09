import { Stack } from 'expo-router';
import { SQLiteProvider } from 'expo-sqlite';
import { Suspense, useEffect, useState } from 'react';

import { ActivityIndicator, StatusBar } from "react-native";

import { DB_NAME, initDb } from '@/db/db';

import BgContainer from '@/components/customs/bg-container';
import { ModalsProvider } from '@/contexts/modal-context';

import '@/global.css';

export default function RootLayout() {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    initDb().catch(() => setError(true)).finally(() => setLoading(false));
  }, []);

  if (loading || error) {
    return (
      <BgContainer className="absolute inset-0 justify-center items-center">
        <ActivityIndicator size="large" color="#f97316" />
      </BgContainer>
    );
  }

  return (
    <Suspense fallback={<ActivityIndicator size="large" />}>
      <SQLiteProvider
        databaseName={DB_NAME}
        options={{ enableChangeListener: true }}
        useSuspense>
        <ModalsProvider>
          <StatusBar backgroundColor="#0F1115" barStyle="light-content" />
          <Stack>
            <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
          </Stack>
        </ModalsProvider>
      </SQLiteProvider>
    </Suspense>
  );
}