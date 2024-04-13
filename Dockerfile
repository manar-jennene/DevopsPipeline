# Utiliser une image Ubuntu en tant que base
FROM ubuntu:latest

# Mettre à jour les paquets et installer Java
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get clean;

# Copier le fichier JAR construit dans le conteneur
COPY target/achat-1.0-SNAPSHOT.jar /app/achat.jar

# Commande par défaut à exécuter lorsque le conteneur démarre
CMD ["java", "-jar", "/app/achat.jar"]
