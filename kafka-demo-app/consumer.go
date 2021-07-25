package main

import (
	"context"
	"github.com/segmentio/kafka-go"
)

func consume(ctx context.Context) {
	dialer := saslScramDialer()
	//dialer := plainDialer()

	// initialize a new reader with the brokers and topic
	// the groupID identifies the consumer and prevents
	// it from receiving duplicate messages
	r := kafka.NewReader(kafka.ReaderConfig{
		Brokers: brokers,
		Topic:   topic2,
		GroupID: group,
		Logger:  kafka.LoggerFunc(log.Debugf),
		Dialer:  dialer,
	})
	for {
		// the `ReadMessage` method blocks until we receive the next event
		msg, err := r.ReadMessage(ctx)
		if err != nil {
			log.Panicf("%v could not read message: %v", getHostname(), err.Error())
		}
		// after receiving the message, log its value
		log.Debugf("%v received message: %v", getHostname(), string(msg.Value))
	}
}
