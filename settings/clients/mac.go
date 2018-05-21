package client

import (
	"fmt"

	util "github.com/kamontat/my_settings/settings/utils"
)

type macClient struct {
	ask           bool
	short         string
	long          string
	defaultString string
}

type callBack struct {
	next  macClient
	chain bool
}

func (callBack callBack) Chain(shortDoc string, longDoc string) macClient {
	return macClient{
		ask:           callBack.chain,
		short:         shortDoc,
		long:          longDoc,
		defaultString: "",
	}
}

func SetupDoc(shortDoc string, longDoc string, defaultString string) macClient {
	return macClient{
		short:         shortDoc,
		long:          longDoc,
		ask:           true,
		defaultString: defaultString,
	}
}

// S is a short command of SetupDoc with default=""
func S(shortDoc string, longDoc string) macClient {
	return SetupDoc(shortDoc, longDoc, "")
}

func (mac macClient) SetDoc(shortDoc string, longDoc string) macClient {
	mac.short = shortDoc
	mac.long = longDoc
	return mac
}

func (mac macClient) SetDefault(defaultString string) macClient {
	mac.defaultString = defaultString
	return mac
}

// D is a short command of SetDefault
func (mac macClient) D(defaultString string) macClient {
	return mac.SetDefault(defaultString)
}

func (mac macClient) WithPromptYesNo() macClient {
	// fmt.Println(mac.long)
	if mac.ask {
		mac.ask = util.PromptYesNo(mac.defaultString == "true", mac.short, mac.long)
	}
	return mac
}

// YN is a short command of WithPromptYesNo
func (mac macClient) YN() macClient {
	return mac.WithPromptYesNo()
}

func (mac macClient) WithPromptValue(value *string) macClient {
	// the target to write to
	if mac.ask {
		util.PromptWithValue(value, mac.defaultString, mac.short, mac.long)
	}
	return mac
}

func (mac macClient) V(value *string) macClient {
	return mac.WithPromptValue(value)
}

func (mac macClient) WithPromptChoose(value *string, list []string) macClient {
	// the target to write to
	if mac.ask {
		util.PromptChooseWithValue(value, list, mac.defaultString, mac.short, mac.long)
	}
	return mac
}

func (mac macClient) C(value *string, list []string) macClient {
	return mac.WithPromptChoose(value, list)
}

func (mac macClient) DefaultWrite(args ...string) callBack {
	if !mac.ask {
		return callBack{
			next:  mac,
			chain: false,
		}
	}
	var arr = []string{"write"}
	arr = append(arr, args...)

	err := rawCommandWithDefaultSTD("defaults", arr...)
	if err != nil {
		return callBack{
			next:  mac,
			chain: false,
		}
	}

	return callBack{
		next:  mac,
		chain: true,
	}
}

// W is a short command of DefaultWrite
func (mac macClient) W(args ...string) callBack {
	return mac.DefaultWrite(args...)
}

func (mac macClient) DefaultRead(args ...string) callBack {
	if !mac.ask {
		return callBack{
			next:  mac,
			chain: false,
		}
	}

	fmt.Println(mac.short)

	var arr = []string{"read"}
	arr = append(arr, args...)

	err := rawCommandWithDefaultSTD("defaults", arr...)
	if err != nil {
		return callBack{
			next:  mac,
			chain: false,
		}
	}

	return callBack{
		next:  mac,
		chain: true,
	}
}

// R is a short command of DefaultRead
func (mac macClient) R(args ...string) callBack {
	return mac.DefaultRead(args...)
}

func (mac macClient) Reset(application string) {
	fmt.Println(mac.long)
	rawCommandWithDefaultSTD("killall", application)
}
