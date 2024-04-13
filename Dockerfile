# Utiliser une image de base qui contient Java (par exemple openjdk)
FROM openjdk:11-jre-slim

# Copier le fichier JAR depuis le répertoire target local dans le conteneur
COPY target/achat-1.0.jar /app/

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Commande par défaut à exécuter lorsque le conteneur démarre
CMD ["java", "-jar", "achat-1.0.jar"]
