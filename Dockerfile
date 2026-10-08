#
#    Copyright 2010-2023 the original author or authors.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#       https://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

#FROM openjdk:17.0.2
#COPY . /usr/src/myapp
#WORKDIR /usr/src/myapp
#RUN ./mvnw clean package
#CMD ./mvnw cargo:run -P tomcat90

# syntax=docker/dockerfile:1
# --- Build Stage ---
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /usr/src/myapp

# Copy wrapper and descriptor first to cache dependencies
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN chmod +x ./mvnw

# Pre-fetch plugins and dependencies
RUN ./mvnw dependency:resolve -B --no-transfer-progress

# Copy application sources
COPY src/ ./src/

# Package the WAR file, skipping tests, rewrite, and formatters
RUN ./mvnw clean package \
    -DskipTests \
    -Dlicense.skip=true \
    -Drewrite.skip=true \
    -Dformatter.skip=true \
    -Dimpsort.skip=true \
    -B --no-transfer-progress

# --- Runtime Stage (Official Tomcat 9 with JDK 17) ---
FROM tomcat:9.0-jdk17-temurin

# Clean out default Tomcat sample apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from builder stage as the ROOT application
COPY --from=builder /usr/src/myapp/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]