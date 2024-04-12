
FROM alpine
RUN apk add openjdk11

# Exposez le port sur lequel votre application va communiquer
EXPOSE 8082
CMD "jave"

# Ajoutez le fichier jar compilé dans l'image Docker
ADD target/achat-1.0-SNAPSHOT.jar achat-1.0-SNAPSHOT.jar

# Commande pour exécuter l'application
ENTRYPOINT ["java","-jar","/achat-1.0-SNAPSHOT.jar"]

