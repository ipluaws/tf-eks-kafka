package eu.unite.recruiting.producer;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;

import java.util.Properties;

@SpringBootApplication
public class Application {

    @Bean
    public KafkaProducer<String, String> producer() {
        Properties properties = new Properties();
        properties.put("bootstrap.servers", "kafka-cluster-kafka-bootstrap.kafka.svc.cluster.local:9092");
        properties.put("retries", 5);
        properties.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        properties.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        
        return new KafkaProducer<>(properties);
    }

    public static void main(String[] args) {
        ApplicationContext ctx = SpringApplication.run(Application.class, args);
    }
    
}

