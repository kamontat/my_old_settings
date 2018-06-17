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
}

// AdvanceWithInternet called to setup advance mac which require internet
func (ms MacSetup) AdvanceWithInternet() {
	if b, e := util.CheckConnection(); !b {
		util.GetLogger().WithError(e).Fatal("Setup (ADV)", "setting with network")
		return
	}
	util.GetLogger().Debug("Setup (ADV)", "setting with network")
}
