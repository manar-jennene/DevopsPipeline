
FROM alpine
RUN apk add openjdk11

# Exposez le port sur lequel votre application va communiquer
EXPOSE 8082
CMD "java"

# Ajoutez le fichier jar compilé dans l'image Docker
ADD target/timesheet-devops-1.0.jar timesheet-devops-1.0.jar

# Commande pour exécuter l'application
ENTRYPOINT ["java","-jar","/timesheet-devops-1.0.jar"]

