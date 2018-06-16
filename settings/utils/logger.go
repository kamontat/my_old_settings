package util

import (
	"os"
	"strings"

	"github.com/heirko/go-contrib/logrusHelper"
	_ "github.com/heralight/logrus_mate/hooks/file"
	"github.com/sirupsen/logrus"
	"github.com/spf13/viper"
)

type LOGTYPE int8

type Logger struct {
	entry logrus.Entry
}

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
	FORMAT              = "[%-12s]: %s \n"
	FORMAT_WITHOUT_LINE = "[%-12s]: %s "
)

func Init(viper *viper.Viper) {
	c := logrusHelper.UnmarshalConfiguration(viper)
	logrusHelper.SetConfig(logrus.StandardLogger(), c)
}

func _log(entry logrus.Entry, logType LOGTYPE, title string, message string) {
	var currentFormat = FORMAT_WITHOUT_LINE
	var newTitle = strings.ToUpper(title)
	// if len(message) == 0 {
	// 	currentFormat = FORMAT
	// }
	switch logType {
	case PANIC:
		entry.Panicf(currentFormat, newTitle, message)
	case FATAL:
		entry.Fatalf(currentFormat, newTitle, message)
	case ERROR:
		entry.Errorf(currentFormat, newTitle, message)
	case WARN:
		entry.Warnf(currentFormat, newTitle, message)
	case LOG:
		entry.Printf(currentFormat, newTitle, message)
	case DEBUG:
		entry.Debugf(currentFormat, newTitle, message)
	case INFO:
		entry.Infof(currentFormat, newTitle, message)
	}
}

func (logger Logger) WithError(err error) Logger {
	logger.entry = *logrus.WithError(err)
	return logger
}

func (logger Logger) WithField(fields logrus.Fields) Logger {
	logger.entry = *logrus.WithFields(fields)
	return logger
}

func GetLogger() Logger {
	return Logger{
		entry: *logrus.WithFields(logrus.Fields{}),
	}
}

func (logger Logger) Log(title string, message string) {
	_log(logger.entry, LOG, title, message)
}

func (logger Logger) Debug(title string, message string) {
	_log(logger.entry, DEBUG, title, message)
}

func (logger Logger) Error(title string, message string) Logger {
	_log(logger.entry, ERROR, title, message)
	return logger
}

func (logger Logger) Exit(exitCode int) {
	os.Exit(exitCode)
}
