# Usar una imagen base de nginx desde Docker Hub
FROM nginx:alpine
 
# Copiar el archivo HTML al directorio de nginx
COPY index.html /usr/share/nginx/html/index.html
 
# Exponer el puerto 80
EXPOSE 80
 
# Comando para ejecutar nginx
CMD ["nginx", "-g", "daemon off;"]