

import Input, { InputProps } from "@/components/inputs/input";
import Column from "@/components/spaces/column";
import InputLabel from "./input-label";

interface InputWithLabelProps extends InputProps {
    label: string;
    placeholder: string;
}

export default function InputWithLabel({ label, placeholder, ...props }: InputWithLabelProps) {
    return (
        <Column className="mb-2 min-h-24"  >
            <InputLabel label={label} />

            <Input
                placeholder={placeholder}
                {...props}
            />
        </Column>
    );
}