1. START ZOOKEEPER - bin\windows\zookeeper-server-start.bat etc\kafka\zookeeper.properties
2. START KAFKA SERVER - bin\windows\kafka-server-start.bat etc\kafka\server.properties
3. START SCHEMA REGISTRY - bin\windows\schema-registry-start.bat etc\schema-registry\schema-registry.properties
4. START SIMPLE CONSOLE PRODUCER WITH SCHEMA - bin\windows\kafka-avro-console-producer.bat --broker-list localhost:9092 --topic s3_test_topic --property value.schema={"""type""":"""record""","""name""":"""myrecord""","""fields""":[{"""name""":"""f1""","""type""":"""string"""}]}
5. START S3 SINK WORKER - bin\windows\connect-standalone.bat etc\kafka\connect-standalone.properties etc\kafka-connect-s3\quickstart-s3.properties