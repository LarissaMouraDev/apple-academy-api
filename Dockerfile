FROM openjdk:21-jdk-slim

WORKDIR /app

# Copiar o Maven Wrapper e pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Dar permissão de execução ao mvnw
RUN chmod +x mvnw

# Baixar dependências (cache layer)
RUN ./mvnw dependency:go-offline -B

# Copiar código fonte
COPY src src

# Compilar aplicação
RUN ./mvnw clean package -DskipTests

# Expor porta
EXPOSE 8080

# Executar aplicação
CMD ["sh", "-c", "java -jar target/*.jar"]
