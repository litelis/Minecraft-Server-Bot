# 🟢 Minecraft Server Bot para Raspberry Pi

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/Python-3.8%2B-blue.svg)](https://www.python.org/)

**Bot de Discord que automatiza un servidor Vanilla/PaperMC 1.21+ en Raspberry Pi** con comandos slash `/start_server` y `/stop_server`.

## 🎯 Descripción

Este repositorio contiene un bot de Discord completo que permite **iniciar y detener** un servidor de Minecraft en tu Raspberry Pi con un solo comando. Perfecto para servidores pequeños (2-10 jugadores).

**Características:**
- ✅ Comandos slash modernos de Discord
- ✅ Gestión automática con Screen
- ✅ PaperMC optimizado para ARM (Raspberry Pi)
- ✅ Configuración automática de memoria RAM
- ✅ Detención segura del servidor
- ✅ Listo para producción 24/7

## 🏗️ Arquitectura del Sistema

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│   Discord Bot   │────▶│   Raspberry Pi   │────▶│ Minecraft Server│
│   (bot.py)      │     │   (Linux ARM)    │     │   (minecraft/)  │
└─────────────────┘     └────────┬─────────┘     └─────────────────┘
                                │
                       ┌────────▼─────────┐
                       │ Screen Session   │
                       │ (minecraft)      │
                       └──────────────────┘
```

## 💻 Requisitos de Hardware (Raspberry Pi)

| Modelo | RAM Recomendada | Jugadores | Estabilidad |
|--------|-----------------|-----------|-------------|
| Pi 3B+ | **❌ No recomendado** | 1-2 | Baja |
| **Pi 4 (4GB)** | ✅ **Recomendado** | 2-6 | Excelente |
| **Pi 4 (8GB)** | 🎖️ **Óptimo** | 6-12 | Perfecta |
| **Pi 5 (4GB+)** | 🚀 **Ideal** | 10-20 | Sobrada |

**Consumo de Recursos (aprox.):**
```
2 jugadores:  800MB RAM, 20-30% CPU
5 jugadores: 1400MB RAM, 50-70% CPU  
10 jugadores: 1900MB RAM, 80-95% CPU
```

## 🛠️ Instalación Paso a Paso (Raspberry Pi)

### 1. Preparar Sistema
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip python3-venv screen wget curl git -y
```

### 2. Clonar Repositorio
```bash
git clone https://github.com/tu-usuario/minecraft-server-bot.git
cd minecraft-server-bot
```

### 3. Configurar Entorno Python
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 4. Configurar Bot Discord
1. Crea un bot en [Discord Developer Portal](https://discord.com/developers/applications)
2. Copia el **TOKEN** del bot
3. Crea archivo `.env`:
```
DISCORD_TOKEN=tu_token_aqui
```
4. Invita el bot a tu servidor con **scope de comandos de aplicación**

### 5. Dar permisos a scripts
```bash
chmod +x start_server.sh stop_server.sh
```

### 6. Iniciar Bot
```bash
python bot.py
```

## 🎮 Comandos del Bot

| Comando | Descripción | Permisos |
|---------|-------------|----------|
| `/start_server` | ✅ Inicia servidor Minecraft | Todos |
| `/stop_server` | ⏹️ Detiene servidor | Todos |

## 🔧 Configuración Avanzada

### Editar memoria RAM
En `start_server.sh`:
```bash
RAM_MIN="1024M"  # Cambiar según tu Pi
RAM_MAX="2048M"
```

### Puerto del servidor
Edita `minecraft_server/server.properties` después del primer inicio:
```
server-port=25565
```

### Autoreinicio
Para restart automático cada 6h, edita `start_server.sh`:
```bash
screen -dmS minecraft bash -c "while true; do java ...; sleep 21600; done"
```

## 🐳 Docker (Opcional)

```bash
docker build -t minecraft-bot .
docker run -d --restart=always -v $(pwd):/app minecraft-bot
```

## 📊 Monitoreo

**Comandos útiles:**
```bash
# Ver logs del servidor
screen -r minecraft

# Ver uso de RAM
free -h

# Ver procesos Java
ps aux | grep java

# Monitoreo en tiempo real
htop
```

## 🤔 Solución de Problemas

| Problema | Solución |
|----------|----------|
| `eula.txt` | Se genera automáticamente |
| `OutOfMemory` | Reduce `RAM_MAX` en `start_server.sh` |
| Bot no responde | Verifica `.env` y permisos del bot |
| Puerto ocupado | Cambia `server.properties` |

## 📈 Rendimiento Optimizado

Este setup está **optimizado específicamente para ARM** (Raspberry Pi):
- PaperMC (fork optimizado de Vanilla)
- Flags de Java ARM-native
- Screen para estabilidad 24/7
- Gestión inteligente de memoria

## 🚀 Contribuir

1. Fork del repositorio
2. Crea feature branch (`git checkout -b feature/xyz`)
3. Commit (`git commit -m 'Add xyz'`)
4. Push (`git push origin feature/xyz`)
5. Abre Pull Request

## 📄 Licencia

Este proyecto está bajo la [Licencia MIT](LICENSE) - ver archivo `LICENSE` para detalles.

---

**¡Listo para jugar! 🎮** Clona, configura y disfruta de tu servidor Minecraft 24/7 controlado por Discord.

**Creado con ❤️ para la comunidad Raspberry Pi + Minecraft**
