package setup

import client "github.com/kamontat/my_settings/settings/clients"

// MacDockSetup is the command able to interact to outer package
// this using parameter to define which type of setup
func MacDockSetup(mode Mode) {
	macSimpleDockSetup(mode == ADVANCE)
	if mode == ADVANCE {
		macAdvanceDockSetup()
	}
}

// macAdvanceDockSetup @noNetwork @dock @advance
func macAdvanceDockSetup() {
	value := ""

	client.S("Single App Mode", `When clicking app icons in the Dock, all other apps are hidden in the background.`).
		D("false").
		YNV(&value).
		P().
		W("com.apple.dock", "single-app", "-bool", value)

	client.S("Scroll wheel hover", `While hovering an icon in the Dock, use the scroll wheel to expose all the windows in the app.`).
		D("true").
		YNV(&value).
		P().
		W("com.apple.dock", "scroll-to-open", "-bool", value)

	client.S("Auto hide and show dock", `Hides the Dock when the mouse cursor is not in its general vicinity, and slides it open when it is.`).
		D("true").
		YN().
		W("com.apple.dock", "autohide", "-bool", "true").
		Chain("Auto hide delay", `How long before the Dock automatically hides when the mouse cursor exits its location.`).
		D("0.0").
		V(&value).
		P().
		W("com.apple.dock", "autohide-delay", "-float", value).
		Chain("Auto hide speed", `The speed at which the Dock animates closed.`).
		D("1.0").
		V(&value).
		P().
		W("com.apple.dock", "autohide-time-modifier", "-float", value)

	client.S("reset dock", "refresh dock for apply new setting").
		Reset("Dock")
}

// macSimpleDockSetup @noNetwork @dock @basic
func macSimpleDockSetup(reset bool) {
	value := ""

	client.S("Icon size", `Manually set the size of the icons in the Dock.`).
		D("68").
		V(&value).
		W("com.apple.dock", "tilesize", "-int", value)

	client.S("Enable Magnification", `Icons in the Dock will enlarge when the mouse hovers over them.`).
		D("true").
		YN().
		W("com.apple.dock", "magnification", "-bool", "true").
		Chain("Magnification", `The size, in pixels, of the icons when the mouse hovers over items in the Dock.`).
		D("94").
		V(&value).
		W("com.apple.dock", "largesize", "-int", value)

	client.S("Minimization effect", `the animation which is used to show windows being minimized into the Dock.`).
		D("suck").
		C(&value, []string{"genie", "scale", "suck"}).
		W("com.apple.dock", "mineffect", "-string", value)

	client.S("Position", `The side of the screen the Dock is located on.`).
		D("bottom").
		C(&value, []string{"bottom", "left", "right"}).
		W("com.apple.dock", "orientation", "-string", value)

	if reset {
		client.S("reset dock", "refresh dock for apply new setting").
			Reset("Dock")
	}
}
