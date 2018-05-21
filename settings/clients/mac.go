package client

// Usage
// 1. Setup document
//     SetupDoc(short, long, default) | S(short, long)
//         CAN BE CHAIN TO [ SetDoc(short, long) ] | [ SetDefault(default) | D(default) ]
// 2. Prompt (optional)
//     [ WithPromptYesNo() | YN() | WithPromptYesNoValue(val) | YNV(val) ] -- prompt as yes no question
//     [ WithPromptValue(value) | V(value) ]                               -- prompt as input question
//     [ WithPromptChoose(value, list) | C(value, list) ]                  -- prompt as choose from list
// 2.x Extra information
//     Prompt will use data from macClient struct, which is
//       1. Help    - mac.long
//       2. Title   - mac.short
//       3. Default - mac.defaultString
// 3. Bypass (optional)
//     [ ByPass() | P() ]                -- by default, Application will NOT chain if user input no/false to prompt
//                                       -- chain by this will suspended this behavior
// 4. Action
//     [ DefaultWrite(args) | W(args) ]  -- write setting thought defaults command in macOS
//     [ DefaultRead(args) | R(args) ]   -- read setting by defaults command in macOS
//     [ Reset(app) ]                    -- kill application to apply
// 5. Extra chain to other macClient
//     On 'DefaultWrite' and 'DefaultRead' commands will return struct call callBack
//     that exist 1 method called 'Chain(short, long)', This method act like 'SetupDoc()'
//     so you can chain to other command directly. This chain will STOP if match one of this condition
//         1. User enter 'no' in YesNoQuestion
//
// Example
// 1. client.S("short help", "long help").
//      D("false").
//      YN().
//      P().
//      DefaultWrite("some", "command")

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

func (mac macClient) WithPromptYesNoValue(value *string) macClient {
	if mac.ask {
		util.PromptYesNoWithValue(value, mac.defaultString == "true", mac.short, mac.long)
		mac.ask = *value == "true"
	}
	return mac
}

// YN is a short command of WithPromptYesNo
func (mac macClient) YN() macClient {
	return mac.WithPromptYesNo()
}

// YN is a short command of WithPromptYesNo
func (mac macClient) YNV(value *string) macClient {
	return mac.WithPromptYesNoValue(value)
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

func (mac macClient) ByPass() macClient {
	mac.ask = true
	return mac
}

// YN is a short command of ByPass
func (mac macClient) P() macClient {
	return mac.ByPass()
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
