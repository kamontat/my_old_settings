package setup

import (
	"fmt"

	util "github.com/kamontat/my_settings/settings/utils"
)

// Setup is struct that contain user setting and system
type Setup struct {
	os       string
	internet bool
	bypass   bool
}

// Initial will create Setup object for setup computer and application
func Initial(os string, internet bool, bypass bool) Setup {
	util.InitialPrompt(bypass)

	return Setup{
		os:       os,
		internet: internet,
		bypass:   bypass,
	}
}

// StartSimple is a method in Setup, which able to setup computer in simple way
func (s Setup) StartSimple() {
	// TODO: Add this condition, if more OS support
	isMac, macSetup := IsMac(s.os)
	if isMac {
		macSetup.Simple(s)
	}
}

// StartAdvance is a method in Setup, which able to setup computer in advance way
func (s Setup) StartAdvance() {
	// TODO: Add this condition, if more OS support
	isMac, macSetup := IsMac(s.os)
	if isMac {
		macSetup.Advance(s)
	}
}

// ToString is the Setup output format
func (s Setup) ToString() string {
	return fmt.Sprintf("os: %s, internet: %t", s.os, s.internet)
}
