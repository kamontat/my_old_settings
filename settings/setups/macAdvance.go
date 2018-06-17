package setup

import (
	util "github.com/kamontat/my_settings/settings/utils"
)

// AdvanceWithoutInternet called to setup advance mac without internet
func (ms MacSetup) AdvanceWithoutInternet() {
	util.GetLogger().Debug("Setup (ADV)", "setting without network")

	if util.PromptYesNo(true, "Setup Dock", "dock setting set") {
		MacDockSetup(ADVANCE)
	}
	if util.PromptYesNo(true, "Setup System", "system setting set") {
		MacSystemSetup(ADVANCE)
	}

	// TODO: Add more advance setup without internet
}

// AdvanceWithInternet called to setup advance mac which require internet
func (ms MacSetup) AdvanceWithInternet() {
	if b, e := util.CheckConnection(); !b {
		util.GetLogger().WithError(e).Fatal("Setup (ADV)", "setting with network")
		return
	}
	util.GetLogger().Debug("Setup (ADV)", "setting with network")

	if util.PromptYesNo(true, "Setup zsh", "install myzs setup (https://github.com/kamontat/myzs)") {
		ZshSetup()
	}

	// TODO: Add more advance setup with internet
}
