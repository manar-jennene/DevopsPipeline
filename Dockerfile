FROM alpine
RUN apk add openjdk11
COPY achat-1.0.jar /app/
WORKDIR /app
EXPOSE 80
CMD ["java", "-jar", "achat-1.0.jar"]
