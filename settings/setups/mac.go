package setup

// Mode is a string for parse to setup method
type Mode string

// MacSetup is the object that for setup mac
type MacSetup struct {
}

const (
	// SIMPLE is the setup mode
	SIMPLE Mode = "SiMpLe"
	// ADVANCE is the setup mode
	ADVANCE Mode = "aDvANcE"
)

// IsMac is the condition method that will return setup object if current system is mac
// otherwise will return false
func IsMac(os string) (bool, MacSetup) {
	if os == "Darwin" {
		return true, MacSetup{}
	}
	return false, MacSetup{}
}

// Simple will called mac setup with simple way
func (ms MacSetup) Simple(setupSettings Setup) {
	ms.SimpleWithoutInternet()
	if setupSettings.internet {
		ms.SimpleWithInternet()
	}
}

// Advance will called mac setup with advance way
func (ms MacSetup) Advance(setupSettings Setup) {
	ms.AdvanceWithoutInternet()
	if setupSettings.internet {
		ms.AdvanceWithInternet()
	}
}
