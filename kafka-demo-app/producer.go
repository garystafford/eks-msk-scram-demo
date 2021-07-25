package main

import (
	"context"
	"strconv"
	"time"

	"github.com/segmentio/kafka-go"
)

func produce(ctx context.Context) {
	dialer := saslScramDialer()
	//dialer := plainDialer()

	// initialize the writer with the broker addresses, and the topic
	w := kafka.NewWriter(kafka.WriterConfig{
		Brokers:  brokers,
		Topic:    topic1,
		Balancer: &kafka.Hash{},
		Logger:   kafka.LoggerFunc(log.Debugf),
		Dialer:   dialer,
	})

	// initialize a counter
	i := 0

	for {
		// each kafka message has a key and value. The key is used
		// to decide which partition (and consequently, which broker)
		// the message gets published on
		err := w.WriteMessages(ctx, kafka.Message{
			Key: []byte(strconv.Itoa(i)),
			// create an arbitrary message payload for the value
			Value: []byte("This is message " + strconv.Itoa(i) + " from host " + getHostname()),
		})
		if err != nil {
			log.Panicf("%v could not write message: %v", getHostname(), err.Error())
		}

		// log a confirmation once the message is written
		log.Debugf("%v - total writes: %v", getHostname(), i)
		i++
		// sleep for a x seconds
		msgFreq, _ := strconv.Atoi(messageFreq)
		time.Sleep(time.Duration(msgFreq))
	}
}
