package setup

import (
	"fmt"

	client "github.com/kamontat/my_settings/settings/clients"
	util "github.com/kamontat/my_settings/settings/utils"
)

// MacAdvanceWithoutInternet called to setup advance mac withut internet
func MacAdvanceWithoutInternet() {
	if util.PromptYesNo(true, "Setup Dock", "dock setting set") {
		MacAdvanceDockSetup()
	}
	if util.PromptYesNo(true, "Setup System", "system setting set") {
		MacAdvanceSystemSetup()
	}
}

// MacAdvanceWithInternet called to setup advance mac which require internet
func MacAdvanceWithInternet() {
	fmt.Println("setup with net")
}

// MacAdvanceSystemSetup @noNetwork @dock @advance
func MacAdvanceSystemSetup() {
	client.S("Disable Mission Control", `Completely disable Mission Control.`).
		YN().
		W("com.apple.dock", "mcx-expose-disabled", "-bool", "false")

	client.S("Disable Dashboard", "Completely disable Dashboard.").
		YN().
		W("com.apple.dashboard", "mcx-disabled", "-bool", "false")

	client.S("Developer mode in Dashboard", "Allows Dashboard widgets to exist outside of the Dashboard area.").
		D("false").
		YN().
		W("com.apple.dashboard", "devmode", "-bool", "true")
}

// MacAdvanceDockSetup @noNetwork @dock @advance
func MacAdvanceDockSetup() {
	MacDockSetup(false)

	client.S("Single App Mode", `When clicking app icons in the Dock, all other apps are hidden in the background.`).
		YN().
		W("com.apple.dock", "single-app", "-bool", "true")

	client.S("Scroll wheel hover", `While hovering an icon in the Dock, use the scroll wheel to expose all the windows in the app.`).
		D("true").
		YN().
		W("com.apple.dock", "scroll-to-open", "-bool", "true")

	client.S("reset dock", "refresh dock for apply new setting").
		Reset("Dock")
}
