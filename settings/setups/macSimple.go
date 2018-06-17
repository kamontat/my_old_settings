package setup

import (
	util "github.com/kamontat/my_settings/settings/utils"
)

// SimpleWithoutInternet called to setup mac without internet
func (ms MacSetup) SimpleWithoutInternet() {
	util.GetLogger().Debug("Setup", "setting without network")

	if util.PromptYesNo(true, "Setup Dock", "dock setting set") {
		MacDockSetup(SIMPLE)
	}
}

// SimpleWithInternet called to setup mac which require internet
func (ms MacSetup) SimpleWithInternet() {
	if b, e := util.CheckConnection(); !b {
		util.GetLogger().WithError(e).Fatal("Setup", "setting with network")
		return
	}
	util.GetLogger().Debug("Setup", "setting with network")
}
