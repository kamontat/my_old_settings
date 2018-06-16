package util

import "net/http"

var netError error
var netComplete string

func CheckConnection() (bool, error) {
	resp, err := http.Get("http://google.com/")
	if err != nil {
		netError = err
		return false, err
	}
	netComplete = string(resp.StatusCode) + resp.Status
	return true, nil
}

func ReportConnection() string {
	if b, _ := CheckConnection(); b {
		return netComplete
	}
	return netError.Error()
}
