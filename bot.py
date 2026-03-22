import discord
from discord.ext import commands
from discord import app_commands
import subprocess
import os
from dotenv import load_dotenv
import logging

# Load environment variables
load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Bot setup
intents = discord.Intents.default()
intents.message_content = True
bot = commands.Bot(command_prefix='!', intents=intents)

# Paths to scripts (configurable)
START_SCRIPT = './start_server.sh'
STOP_SCRIPT = './stop_server.sh'

@bot.event
async def on_ready():
    print(f'{bot.user} has connected to Discord!')
    try:
        synced = await bot.tree.sync()
        print(f'Synced {len(synced)} command(s)')
    except Exception as e:
        print(f'Failed to sync commands: {e}')

@bot.tree.command(name='start_server', description='Inicia el servidor de Minecraft en background')
async def start_server(interaction: discord.Interaction):
    if not os.path.exists(START_SCRIPT):
        await interaction.response.send_message('❌ Error: start_server.sh no encontrado. Verifica la instalación.', ephemeral=True)
        return
    
    await interaction.response.defer(ephemeral=True)
    
    try:
        result = subprocess.run([START_SCRIPT], capture_output=True, text=True, timeout=10)
        if result.returncode == 0:
            await interaction.followup.send('✅ Servidor de Minecraft iniciado en background usando Screen.', ephemeral=True)
            logging.info('Servidor iniciado exitosamente')
        else:
            await interaction.followup.send(f'❌ Error al iniciar servidor:\n{result.stderr}', ephemeral=True)
            logging.error(f'Error iniciando servidor: {result.stderr}')
    except subprocess.TimeoutExpired:
        await interaction.followup.send('❌ Timeout al iniciar el servidor.', ephemeral=True)
    except Exception as e:
        await interaction.followup.send(f'❌ Error inesperado: {str(e)}', ephemeral=True)
        logging.error(f'Error inesperado: {e}')

@bot.tree.command(name='stop_server', description='Detiene el servidor de Minecraft')
async def stop_server(interaction: discord.Interaction):
    if not os.path.exists(STOP_SCRIPT):
        await interaction.response.send_message('❌ Error: stop_server.sh no encontrado. Verifica la instalación.', ephemeral=True)
        return
    
    await interaction.response.defer(ephemeral=True)
    
    try:
        result = subprocess.run([STOP_SCRIPT], capture_output=True, text=True, timeout=10)
        if result.returncode == 0:
            await interaction.followup.send('✅ Servidor de Minecraft detenido.', ephemeral=True)
            logging.info('Servidor detenido exitosamente')
        else:
            await interaction.followup.send(f'⚠️ Posibles errores al detener:\n{result.stderr}', ephemeral=True)
            logging.warning(f'Error deteniendo servidor: {result.stderr}')
    except subprocess.TimeoutExpired:
        await interaction.followup.send('❌ Timeout al detener el servidor.', ephemeral=True)
    except Exception as e:
        await interaction.followup.send(f'❌ Error inesperado: {str(e)}', ephemeral=True)
        logging.error(f'Error inesperado: {e}')

if __name__ == '__main__':
    TOKEN = os.getenv('DISCORD_TOKEN')
    if not TOKEN:
        print('❌ Error: DISCORD_TOKEN no encontrado en .env')
        exit(1)
    
    bot.run(TOKEN)
