# Imagen base oficial de Python
FROM python:3.11-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de tu proyecto
COPY . /app

# Instala dependencias
RUN pip install --no-cache-dir flask

# Expone el puerto por defecto de Flask
EXPOSE 5000

# Comando para ejecutar la app
CMD ["python", "app.py"]
