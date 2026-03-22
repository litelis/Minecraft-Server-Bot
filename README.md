# 🎮 **MINECRAFT VANILLA SERVER + BOT DISCORD para PRINCIPIANTES** (Raspberry Pi 2026)

**🤯 GUÍA COMPLETA DESDE CERO** - No necesitas saber nada de programación

## 📋 **ÍNDICE**
1. [Requisitos Hardware](#hardware)
2. [Instalación Raspberry Pi Paso a Paso](#instalacion)
3. [Configurar Bot Discord](#discord)
4. [Hacer Servidor PÚBLICO Mundial](#publico)
5. [IP FIJA Gratis (No cambia nunca)](#ipfija)
6. [Comandos Bot](#comandos)

---

## 💻 **1. REQUISITOS HARDWARE** {#hardware}

```
✅ Raspberry Pi 4 (4GB+) o Pi 5 = PERFECTO
✅ MicroSD 32GB+ (Clase 10)
✅ Fuente 5V/3A oficial
✅ Router con puerto 25565
✅ Internet estable
```

**❌ NO funciona:** Pi 3, PC viejo <4GB RAM

---

## 🔧 **2. INSTALACIÓN DESDE CERO** {#instalacion}

### **Paso 1: Preparar Raspberry Pi**
```bash
# Actualizar sistema (IMPORTANTE)
sudo apt update &amp;&amp; sudo apt upgrade -y
sudo apt install -y git wget screen curl python3 python3-pip python3-venv nano htop
sudo reboot
```

### **Paso 2: Clonar Repositorio**
```bash
cd ~
git clone https://github.com/tu-usuario/minecraft-vanilla-bot.git
cd minecraft-vanilla-bot
ls -la  # Ver todos archivos ✓
```

### **Paso 3: Instalar Python**
```bash
python3 -m venv venv
source venv/bin/activate  # (Aparece (venv) )
pip install --upgrade pip
pip install -r requirements.txt
```

### **Paso 4: Primera Ejecución - CREAR SERVIDOR MINECRAFT**
```bash
chmod +x *.sh
./start_server.sh
```

**¡ESPERA 10-15 MINUTOS!** Se descarga:
```
✅ server.jar OFICIAL Vanilla 1.21.4 (https://launcher.mojang.com)
✅ Mundo generado automáticamente  
✅ eula.txt aceptado ✓
```

**Cuando veas "Done" presiona Ctrl+C** para parar.

### **Paso 5: Verificar Mundo Creado**
```bash
ls minecraft_server/
# Debe mostrar: server.jar  eula.txt  server.properties  world/
```

---

## 🔑 **3. CONFIGURAR BOT DISCORD** {#discord}

### **3.1 Crear Bot GRATIS**
1. Ve: https://discord.com/developers/applications
2. **"New Application"** → nombre "MiMinecraftBot"
3. **"Bot"** → **"Add Bot"**
4. **Copy TOKEN** (guárdalo seguro)
5. **OAuth2 → URL Generator**:
   - Scopes: `bot` + `applications.commands`
   - Bot Permissions: `Send Messages`
6. **Pega URL en navegador** → invita a tu servidor Discord

### **3.2 Configurar Token**
```bash
cp .env.example .env
nano .env
```
**Pega tu TOKEN:**
```
DISCORD_TOKEN=MTIzNDU2Nzg5MDEyMzQ1Njc4OXYZ.abc123TuTokenSecreto
```

### **3.3 Iniciar Bot**
```bash
source venv/bin/activate
python bot.py
```
**¡Debe decir:** "Synced 2 command(s)"

---

## 🌍 **4. HACER SERVIDOR PÚBLICO MUNDIAL** {#publico}

### **4.1 Configurar Puerto 25565**
1. **Router** (192.168.1.1):
   - Port Forward: `UDP/TCP 25565` → `IP de tu Pi` (ej: 192.168.1.100)
2. **Ver IP Pi:**
   ```bash
   ip addr show | grep 192.168
   ```
3. **Probar puerto abierto:**
   https://www.yougetsignal.com/tools/open-ports/

### **4.2 Configurar server.properties**
```bash
cd minecraft_server
nano server.properties
```
**Cambios importantes:**
```
server-port=25565
online-mode=true
difficulty=normal
pvp=true
motd=¡Mi Servidor Vanilla Pi!
max-players=10
```
**Guarda: Ctrl+O → Enter → Ctrl+X**

---

## 🏠 **5. IP FIJA GRATIS (No cambia nunca)** {#ipfija}

**Tu IP de internet cambia?** Usa **No-IP GRATIS**:

### **Opción A: No-IP (Recomendado)**
1. Regístrate: https://www.noip.com/sign-up
2. Crea hostname: `mi-minecraft.ddns.net`
3. Instala en Pi:
```bash
wget http://www.no-ip.com/client/noip-duc-linux.zip
unzip noip-duc-linux.zip
cd noip-2.1.9-1/
make
make install
noip2
```
**Configura auto-inicio:**
```bash
crontab -e
# Agrega línea:
@reboot /usr/local/bin/noip2
```

### **Opción B: IP Estática Router**
Router → DHCP → Reserva IP fija para MAC de Pi

**¡Tu servidor ahora es:** `mi-minecraft.ddns.net:25565`

---

## 🎯 **6. COMANDOS BOT DISCORD** {#comandos}

```
En tu Discord:
/start_server  → ✅ Inicia servidor público
/stop_server   → ⏹️ Para servidor

¡Funciona desde móvil/PC!
```

## 🔍 **VERIFICAR TODO FUNCIONA**

```bash
# Estado servidor
screen -ls

# Ver logs
screen -r minecraft

# RAM/CPU
htop

# IP pública
curl ifconfig.me
```

## 🎉 **¡LISTO! Invita Amigos**

**Amigos conectan:**
```
Servidor: mi-minecraft.ddns.net:25565
Versión: 1.21.4 Vanilla
```

---

## 🆘 **PROBLEMAS COMUNES**

| Error | Solución |
|-------|----------|
| "Connection refused" | ✅ Port Forward 25565 |
| "Can't resolve host" | ✅ No-IP configurado |
| "Out of memory" | Usa Pi 4GB+ |
| Bot no responde | Token correcto en .env |

## 📱 **EJECUTAR 24/7 (Auto inicio)**

```bash
# Auto inicio bot
crontab -e
@reboot cd /home/pi/minecraft-vanilla-bot &amp;&amp; source venv/bin/activate &amp;&amp; python bot.py
```

**¡SERVIDOR MINECRAFT VANILLA PÚBLICO funcionando!** 🌍🎮

**Enlaces 2024 actualizados:**
- Vanilla 1.21.4: launcher.mojang.com
- No-IP: noip.com
- Discord Dev: discord.com/developers/applications

**Creado para PRINCIPIANTES TOTALES ✓**
