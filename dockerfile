# Usar una imagen base de nginx desde Docker Hub
FROM nginx:alpine
 
# Copiar el archivo HTML al directorio de nginx
COPY index.html /usr/share/nginx/html/index.html

# Copiar el archivo conf al directorio de nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
 
# Exponer el puerto 80
EXPOSE 80
 
# Comando para ejecutar nginx
CMD ["nginx", "-g", "daemon off;"]