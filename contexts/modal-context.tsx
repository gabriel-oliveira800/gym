import React, { createContext, ReactNode, useState } from 'react';

type AllModalsKeys = '' | 'add-exercise'

interface ModalsContextType {
    isOpen: boolean;
    keys: AllModalsKeys[];
    openModal: (modalKey: AllModalsKeys) => void;
    closeModal: (modalKey: AllModalsKeys) => void;
}

const ModalsContextContext = createContext<ModalsContextType>({
    keys: [],
    isOpen: false,
    openModal: () => { },
    closeModal: () => { }
})

function ModalsProvider({ children }: { children: ReactNode }) {
    const [isOpen, setIsOpen] = useState(false)
    const [keys, setKeys] = useState<AllModalsKeys[]>([])

    const openModal = (modalKey: AllModalsKeys) => {
        setKeys(prev => [...prev, modalKey])
        setIsOpen(true)
    }

    const closeModal = (modalKey: AllModalsKeys) => {
        if (modalKey !== keys[keys.length - 1]) return;
        setKeys(prev => prev.slice(0, prev.length - 1))
        setIsOpen(false)
    }

    return (
        <ModalsContextContext.Provider value={{ keys, isOpen, openModal, closeModal }}>
            {children}
        </ModalsContextContext.Provider>
    )
}

export { ModalsContextContext, ModalsProvider };

