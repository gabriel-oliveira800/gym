import { useContext } from 'react';

import { ModalsContextContext } from '../contexts/modal-context';

export function useModal() {
    const context = useContext(ModalsContextContext)
    if (!context) {
        throw new Error('useModal deve ser usado dentro de um ModalsProvider')
    }
    return context
}
