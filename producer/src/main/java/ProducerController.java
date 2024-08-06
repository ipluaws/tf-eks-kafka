package eu.unite.recruiting.producer;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
public class ProducerController {

    private final KafkaProducer<String, String> producer;

    ProducerController(KafkaProducer<String, String> producer) {
        this.producer = producer;
    }

    @PostMapping("/send/{topic}/{key}")
    public void send(@PathVariable String topic, @PathVariable String key, @RequestBody String value) {
        if (!isValid(value)) throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid request");
        producer.send(new ProducerRecord<>(topic, key, value), (metadata, exception) -> {
            if (exception != null) {
                exception.printStackTrace();
            } else {
                System.out.println("Sent message with key: " + key + " to topic: " + topic + " partition: " + metadata.partition() + " offset: " + metadata.offset());
            }
        });
        producer.flush();
    }

    private boolean isValid(String value) {
        return value != null && !value.trim().isEmpty();
    }
}

