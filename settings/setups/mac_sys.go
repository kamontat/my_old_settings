package setup

import client "github.com/kamontat/my_settings/settings/clients"

// MacSystemSetup is the command able to interact to outer package
// this using parameter to define which type of setup
func MacSystemSetup(mode Mode) {
	if mode == ADVANCE {
		macAdvanceSystemSetup()
	}
}

// macAdvanceSystemSetup @noNetwork @dock @advance
func macAdvanceSystemSetup() {
	client.S("Disable Mission Control", `Completely disable Mission Control.`).
		YN().
		W("com.apple.dock", "mcx-expose-disabled", "-bool", "false")

	client.S("Disable Dashboard", "Completely disable Dashboard.").
		YN().
		W("com.apple.dashboard", "mcx-disabled", "-bool", "false")

	client.S("Dev mode in Dashboard", "Allows Dashboard widgets to exist outside of the Dashboard area.").
		D("false").
		YN().
		W("com.apple.dashboard", "devmode", "-bool", "true")
}
