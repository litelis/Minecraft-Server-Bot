#!/bin/bash

# Script para iniciar servidor Minecraft Vanilla/PaperMC en background con Screen
# Compatible con Raspberry Pi

set -e

# Configuración del servidor
SCREEN_NAME="minecraft"
SERVER_DIR="./minecraft_server"
JAR_FILE="server.jar"
RAM_MIN="1024M"  # Mínimo 1GB para Raspberry Pi 4
RAM_MAX="2048M"  # Máximo recomendado

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Iniciando servidor Minecraft...${NC}"

# Verificar si Screen está instalado
if ! command -v screen &> /dev/null; then
    echo -e "${RED}Screen no está instalado. Instálalo con: sudo apt install screen${NC}"
    exit 1
fi

# Crear directorio del servidor si no existe
if [ ! -d "$SERVER_DIR" ]; then
    echo -e "${YELLOW}Creando directorio del servidor: $SERVER_DIR${NC}"
    mkdir -p "$SERVER_DIR"
fi

cd "$SERVER_DIR"

# Descargar PaperMC si no existe (última versión estable para 1.21.x)
if [ ! -f "$JAR_FILE" ]; then
    echo -e "${YELLOW}Descargando PaperMC...${NC}"
    wget -q https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/62/downloads/paper-1.21.1-62.jar -O "$JAR_FILE"
    echo -e "${GREEN}✓ PaperMC descargado${NC}"
fi

# Verificar sesión Screen existente
if screen -list | grep -q "$SCREEN_NAME"; then
    echo -e "${YELLOW}⚠️  Sesión Screen '$SCREEN_NAME' ya existe. Deteniendo...${NC}"
    ./stop_server.sh
    sleep 3
fi

# Generar eula.txt si no existe
if [ ! -f "eula.txt" ]; then
    echo -e "${YELLOW}Generando eula.txt...${NC}"
    echo "eula=true" > eula.txt
fi

# Iniciar servidor en Screen
echo -e "${YELLOW}Iniciando servidor con ${RAM_MIN}-${RAM_MAX} RAM...${NC}"
screen -dmS "$SCREEN_NAME" bash -c "java -Xms${RAM_MIN} -Xmx${RAM_MAX} -jar $JAR_FILE nogui"

# Esperar a que el servidor arranque
sleep 10

# Verificar si está corriendo
if screen -list | grep -q "$SCREEN_NAME"; then
    echo -e "${GREEN}✓ Servidor Minecraft iniciado correctamente!${NC}"
    echo -e "${YELLOW}Conectar con Screen: screen -r $SCREEN_NAME${NC}"
    echo -e "${YELLOW}Detener servidor: ./stop_server.sh${NC}"
else
    echo -e "${RED}✗ Error: El servidor no se inició correctamente${NC}"
    exit 1
fi
