@echo off
setlocal EnableDelayedExpansion

set AVROPATH=
for %%F in (C:\kafka\share\java\kafka-serde-tools\*) do (
  set AVROPATH=!AVROPATH!;%%F
)
echo %AVROPATH%

set CLASSPATH=%CLASSPATH%%AVROPATH%

"%~dp0schema-registry-run-class.bat" kafka.tools.ConsoleProducer --line-reader io.confluent.kafka.formatter.AvroMessageReader --property schema.registry.url=http://localhost:8081 %*
