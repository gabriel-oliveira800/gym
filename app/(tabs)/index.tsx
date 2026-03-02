import React from "react";
import { Text } from 'react-native';

import BgContainer from "@/components/bg-container";

export default function HomeScreen() {
  return (
    <BgContainer >
      <Text className='text-white'>Home</Text>
    </BgContainer>
  );
}