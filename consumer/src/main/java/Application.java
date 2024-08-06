package eu.unite.recruiting.consumer;

import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;

import java.util.Properties;
import java.util.UUID;

@SpringBootApplication
public class Application {

    @Bean
    public KafkaConsumer<String, String> consumer() {
        Properties properties = new Properties();
        properties.put("bootstrap.servers", "kafka-cluster-kafka-bootstrap.kafka.svc.cluster.local:9092");
        properties.put("enable.auto.commit", "false");
        properties.put("auto.offset.reset", "earliest");
        properties.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        properties.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        properties.put("group.id", UUID.randomUUID().toString());
        return new KafkaConsumer<>(properties);
    }

    public static void main(String[] args) {
        ApplicationContext ctx = SpringApplication.run(Application.class, args);
    }
    
}

