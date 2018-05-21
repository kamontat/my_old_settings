package setup

import (
	"fmt"

	client "github.com/kamontat/my_settings/settings/clients"
	util "github.com/kamontat/my_settings/settings/utils"
)

// MacWithoutInternet called to setup mac without internet
func MacWithoutInternet() {
	if util.PromptYesNo(true, "Setup Dock", "dock setting set") {
		MacDockSetup(true)
	}
}

// MacWithInternet called to setup mac which require internet
func MacWithInternet() {
	fmt.Println("setup with net")
}

// MacDockSetup @noNetwork @dock @basic
func MacDockSetup(reset bool) {
	value := ""

	client.S("Icon size", `Manually set the size of the icons in the Dock.`).
		D("68").
		V(&value).
		W("com.apple.dock", "tilesize", "-int", value)

		// defaults write com.apple.dock magnification -bool true
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
