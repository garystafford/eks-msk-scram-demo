// Purpose: Demonstration Amazon EKS/MSK application
// Author: Gary A. Stafford
// Date: 20201-07-26

package main

import (
	"context"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	lrf "github.com/banzaicloud/logrus-runtime-formatter"
	"github.com/sirupsen/logrus"
)

var (
	logLevel    = getEnv("LOG_LEVEL", "info")
	topic1      = getEnv("TOPIC1", "foo.topic")
	topic2      = getEnv("TOPIC2", "bar.topic")
	group       = getEnv("GROUP", "default-consumer-group")
	messageFreq = getEnv("MSG_FREQ", "60")          // seconds
	region      = getEnv("AWS_REGION", "us-east-1") // seconds
	brokers     []string
	log         = logrus.New()
	sess        = &session.Session{}
)

func getHostname() string {
	hostname, err := os.Hostname()
	if err != nil {
		log.Error(err)
	}
	return hostname
}

func getEnv(key, fallback string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	return fallback
}

func init() {
	childFormatter := logrus.JSONFormatter{}
	runtimeFormatter := &lrf.Formatter{ChildFormatter: &childFormatter}
	runtimeFormatter.Line = true
	log.Formatter = runtimeFormatter
	log.Out = os.Stdout
	level, err := logrus.ParseLevel(logLevel)
	if err != nil {
		log.Error(err)
	}
	log.Level = level
}

func createAwsSession() *session.Session {
	sess, err := session.NewSession(&aws.Config{
		Region: aws.String(region),
	})
	if err != nil {
		log.Fatal(err)
	}

	return sess
}

func main() {
	// create a new context
	ctx := context.Background()
	sess = createAwsSession()
	brokers = getBrokers()

	// produce messages in a new go routine, since
	// both the produce and consume functions are
	// blocking
	go produce(ctx)
	consume(ctx)
}
