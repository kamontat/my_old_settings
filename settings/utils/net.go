package util

import "net/http"

var netError error
var netComplete string

func CheckConnection() bool {
	resp, err := http.Get("http://google.com/")
	if err != nil {
		netError = err
		return false
	}
	netComplete = string(resp.StatusCode) + resp.Status
	return true
}

func ReportConnection() string {
	if CheckConnection() {
		return netComplete
	}
	return netError.Error()
}
