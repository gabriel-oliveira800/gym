import { Check, ChevronDown, ChevronUp } from 'lucide-react-native';
import { useState } from 'react';
import { Text } from "react-native";

import DropDownPicker from 'react-native-dropdown-picker';

import { InputProps } from "@/components/inputs/input";
import Column from "@/components/spaces/column";

export type InputDropdownItem = {
    label: string;
    value: string;
    parent?: string;
}

interface InputDropdownProps extends InputProps {
    label: string;
    placeholder: string;
    currentValue: string;
    items: InputDropdownItem[];
    setValue: (value: InputDropdownItem) => void;
}

export default function InputDropdown({ items, label, placeholder, currentValue, setValue }: InputDropdownProps) {
    const [open, setOpen] = useState(false);
    const borderColor = open ? "#ea580c" : "#374151"

    const handleSetValue = (value: string | null | undefined) => {
        const item = items.find((item) => item.value === value);
        if (item) {
            setValue(item);
            setOpen(false);
        }
    }

    return (
        <Column className="mb-2"  >
            <Text className="text-gray-500 text-[10px] font-bold uppercase mb-4 ml-1 tracking-widest">
                {label}
            </Text>

            <DropDownPicker
                open={open}
                items={items}
                setOpen={setOpen}
                value={currentValue}
                setValue={(it) => { }}
                placeholder={placeholder}
                listMode='SCROLLVIEW'
                placeholderStyle={{ color: "#6b7280" }}
                listItemLabelStyle={{ color: "#ffffff" }}
                arrowIconStyle={{ width: 24, height: 24 }}
                textStyle={{ color: "#ffffff", fontSize: 16 }}
                containerStyle={{ height: 64, width: "100%" }}
                onSelectItem={(value) => handleSetValue(value.value)}
                categorySelectable={true}
                style={{
                    height: 60,
                    borderRadius: 12,
                    paddingHorizontal: 16,
                    borderColor: borderColor,
                    backgroundColor: "#1F2937",
                }}
                dropDownContainerStyle={{
                    borderRadius: 12,
                    borderColor: borderColor,
                    backgroundColor: "#1F2937",
                }}
                searchTextInputStyle={{
                    color: "#ffffff",
                    borderColor: borderColor,
                    backgroundColor: "#1F2937",
                }}
                TickIconComponent={() => (<Check size={20} color="white" />)}
                ArrowUpIconComponent={() => (<ChevronUp size={20} color="white" />)}
                ArrowDownIconComponent={() => (<ChevronDown size={20} color="white" />)}
            />
        </Column>
    );
}