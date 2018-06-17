package setup

type SetupMode string

type MacSetup struct {
}

const (
	SIMPLE  SetupMode = "SiMpLe"
	ADVANCE SetupMode = "aDvANcE"
)

func IsMac(os string) (bool, MacSetup) {
	if os == "Darwin" {
		return true, MacSetup{}
	}
	return false, MacSetup{}
}

func (ms MacSetup) Simple(setupSettings Setup) {
	ms.SimpleWithoutInternet()
	if setupSettings.internet {
		ms.SimpleWithInternet()
	}
}

func (ms MacSetup) Advance(setupSettings Setup) {
	ms.AdvanceWithoutInternet()
	if setupSettings.internet {
		ms.AdvanceWithInternet()
	}
}
