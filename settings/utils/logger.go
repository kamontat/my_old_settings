package util

import (
	"github.com/heirko/go-contrib/logrusHelper"
	_ "github.com/heralight/logrus_mate/hooks/file"
	"github.com/sirupsen/logrus"
	"github.com/spf13/viper"
)

type LOGTYPE int8

const (
	PANIC = -4
	FATAL = -3
	ERROR = -2
	WARN  = -1
	LOG   = 0
	DEBUG = 1
	INFO  = 2
)

const (
	FORMAT = "[%7s]: %s \n"
)

func Init(viper *viper.Viper) {
	c := logrusHelper.UnmarshalConfiguration(viper)
	logrusHelper.SetConfig(logrus.StandardLogger(), c)

	Log("", "")
}

func _log(entry *logrus.Entry, logType LOGTYPE, title string, message string) {
	switch logType {
	case PANIC:
		entry.Panicf(FORMAT, title, message)
	case FATAL:
		entry.Fatalf(FORMAT, title, message)
	case ERROR:
		entry.Errorf(FORMAT, title, message)
	case WARN:
		entry.Warnf(FORMAT, title, message)
	case LOG:
		entry.Printf(FORMAT, title, message)
	case DEBUG:
		entry.Debugf(FORMAT, title, message)
	case INFO:
		entry.Infof(FORMAT, title, message)
	}
}

func _logOnField(fields logrus.Fields) *logrus.Entry {
	return logrus.WithFields(fields)
}

func _justLog() *logrus.Entry {
	return logrus.WithFields(logrus.Fields{})
}

func _error(err error) *logrus.Entry {
	return logrus.WithError(err)
}

func Log(title string, message string) {
	_log(_justLog(), LOG, title, message)
}

func Debug(title string, message string) {
	_log(_justLog(), DEBUG, title, message)
}

func Error(title string, err error) {
	_log(_error(err), ERROR, title, "")
}
