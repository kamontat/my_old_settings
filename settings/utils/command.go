package util

import (
	"fmt"
)

const BUILD = "2"
const VERSION = "1.0.0"

var VERSION_SIMPLE_FORMAT = VersionFormat{
	code:   1,
	title:  "version: ",
	format: "%s %s",
	result: []string{BUILD, VERSION},
}

var VERSION_NORMAL_FORMAT = VersionFormat{
	code:   2,
	title:  "mys version: ",
	format: "%s (%s)",
	result: []string{VERSION, BUILD},
}

var VERSION_DEFAULT_FORMAT = VERSION_NORMAL_FORMAT

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
