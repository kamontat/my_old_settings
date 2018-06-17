package setup

import (
	"fmt"

	util "github.com/kamontat/my_settings/settings/utils"
)

type Setup struct {
	os       string
	internet bool
	bypass   bool
}

func Initial(os string, internet bool, bypass bool) Setup {
	util.InitialPrompt(bypass)

	return Setup{
		os:       os,
		internet: internet,
		bypass:   bypass,
	}
}

func (s Setup) StartSimple() {
	// TODO: Add this condition, if more OS support
	isMac, macSetup := IsMac(s.os)
	if isMac {
		macSetup.Simple(s)
	}
}

func (s Setup) StartAdvance() {
	// TODO: Add this condition, if more OS support
	isMac, macSetup := IsMac(s.os)
	if isMac {
		macSetup.Advance(s)
	}
}

func (s Setup) ToString() string {
	return fmt.Sprintf("os: %s, internet: %t", s.os, s.internet)
}
