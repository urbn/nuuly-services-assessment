package com.nuuly;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

/**
 * This is an example ProducerService that can publish a message to a topic. This can be used if it is autowired to
 * another class.
 * An example of using this is as follows:
 *
 *      <pre>
 *      this.producer.sendInventoryMessage(
 *          key = key,
 *          value = value
 *     )
 *     </pre>
 */
@Service
public class ProducerService {

    private final KafkaTemplate<String, String> kafkaTemplate;

    final String INVENTORY_TOPIC = "inventory_updates";

    @Autowired
    public ProducerService(KafkaTemplate<String, String> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    public void sendInventoryMessage(String key, String message) {
        kafkaTemplate.send(INVENTORY_TOPIC, key, message);
    }
}
