package client

import (
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func rawCommandWithDefaultSTD(name string, arg ...string) (err error) {
	out, stderr, err := rawCommandWithReturn(name, arg...)
	if err == nil {
		fmt.Printf(out)
	} else {
		fmt.Printf(stderr)
		// log.Fatal()
	}
	return
}

func rawCommandWithReturn(name string, arg ...string) (strout string, strerr string, err error) {
	var stdout, stderr bytes.Buffer
	fmt.Println(name, strings.Join(arg, " "))
	cmd := exec.Command(name, arg...)
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr

	err = cmd.Run()
	strout = stdout.String()
	strerr = stderr.String()
	return
}

func rawCommandWithCustomSTD(name string, in *os.File, out *os.File, arg ...string) (err error) {
	cmd := exec.Command(name, arg...)
	cmd.Stdin = in
	cmd.Stdout = out

	err = cmd.Run()
	return
}
