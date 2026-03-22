#!/bin/bash

# Script para detener servidor Minecraft de forma segura
# Compatible con Raspberry Pi

set -e

SCREEN_NAME="minecraft"
SERVER_DIR="./minecraft_server"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Deteniendo servidor Minecraft...${NC}"

# Verificar si existe sesión Screen
if ! screen -list | grep -q "$SCREEN_NAME"; then
    echo -e "${YELLOW}No hay sesión Screen '$SCREEN_NAME' activa.${NC}"
    exit 0
fi

cd "$SERVER_DIR" 2>/dev/null || echo -e "${YELLOW}No se pudo acceder a $SERVER_DIR${NC}"

# Enviar comando 'stop' al servidor (15 segundos de timeout)
echo -e "${YELLOW}Enviando comando 'stop' al servidor...${NC}"
timeout 15 screen -S "$SCREEN_NAME" -p 0 -X stuff $'stop\n'

# Esperar a que el servidor se detenga
echo -e "${YELLOW}Esperando que el servidor se detenga (30s max)...${NC}"
sleep 5

# Verificar si aún está corriendo y forzar kill si es necesario
if screen -list | grep -q "$SCREEN_NAME"; then
    echo -e "${YELLOW}Forzando detención...${NC}"
    screen -S "$SCREEN_NAME" -X quit
    sleep 2
fi

# Cleanup final
screen -wipe >/dev/null 2>&1

if ! screen -list | grep -q "$SCREEN_NAME"; then
    echo -e "${GREEN}✓ Servidor detenido correctamente.${NC}"
else
    echo -e "${RED}✗ Error: No se pudo detener completamente el servidor.${NC}"
    exit 1
fi
