package eu.unite.recruiting.consumer;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.time.Duration;
import java.util.Arrays;

@RestController
public class ConsumerController {

    private final KafkaConsumer<String, String> consumer;

    ConsumerController(KafkaConsumer<String, String> consumer) {
        this.consumer = consumer;
    }

    @GetMapping("/")
    public String index() {
        return "Greetings from Spring Boot!";
    }

    @GetMapping("/recv/{topic}/{key}")
    public String get(@PathVariable String topic, @PathVariable String key) {
        ConsumerRecords<String, String> records = poll(topic);
        if (records.count() == 0) throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "no records found in topic");

        String value = null;
        for (ConsumerRecord<String, String> record : records) {
            if (key.equals(record.key())) {
                value = record.value();
                break;
            }
        }
        if (value == null) throw new ResponseStatusException(HttpStatus.NOT_FOUND, "no records found matching key");

        return value;
    }

    private ConsumerRecords<String, String> poll(String topic) {
        consumer.subscribe(Arrays.asList(topic));
        consumer.poll(0);
        consumer.seekToBeginning(consumer.assignment());
        ConsumerRecords<String, String> records = consumer.poll(Duration.ofSeconds(10));
        consumer.unsubscribe();

        return records;
    }
}

