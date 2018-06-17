package util

import (
	"fmt"
)

// BUILD is a command build number
const BUILD = "3"

// VERSION is a command version
const VERSION = "1.1.0"

// SimpleVersionFormat is a format of command version
// This will create by the template: %s %s
var SimpleVersionFormat = VersionFormat{
	code:   1,
	title:  "version: ",
	format: "%s %s",
	result: []string{VERSION, BUILD},
}

// NormalVersionFormat is a format of command version
// This will create by the template: %s (%s)
var NormalVersionFormat = VersionFormat{
	code:   2,
	title:  "mys version: ",
	format: "%s (%s)",
	result: []string{VERSION, BUILD},
}

// DefaultVersionFormat is the format that use in command
var DefaultVersionFormat = NormalVersionFormat

type VersionFormat struct {
	code   int
	title  string
	format string
	result []string
}

func (vf VersionFormat) GetResult() string {
	s := make([]interface{}, len(vf.result))
	for i, v := range vf.result {
		s[i] = v
	}
	return vf.title + fmt.Sprintf(vf.format, s...)
}

func (vf VersionFormat) PrintResult() {
	fmt.Println(vf.GetResult())
}

func GetVersion(format VersionFormat) string {
	return format.GetResult()
}

func ToVersion(format VersionFormat) {
	format.PrintResult()
}
