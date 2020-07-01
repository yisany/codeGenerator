FROM java:8

RUN mkdir /codeGenerator

ADD generator-web-3.0.1.jar /codeGenerator/web.jar

EXPOSE 1234

ENTRYPOINT ["java", "-jar", "/codeGenerator/web.jar"]

# docker build -t yisany.top/code-generator:v2.0 .
# docker run -it -p 1234:1234 --name code-generator -d yisany.top/code-generator:v2.0



