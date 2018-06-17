package setup

import (
	client "github.com/kamontat/my_settings/settings/clients"
	util "github.com/kamontat/my_settings/settings/utils"
)

const myzsPath = "/tmp/myzs.zip"
const myzsTemp = "/tmp/myzs.temp"
const myzsLink = "https://github.com/kamontat/myzs/archive/master.zip"

// ZshSetup is a method that will download myzs repository and install it in current computer
// @network @zsh @advance
func ZshSetup() {
	util.GetLogger().Debug("Zsh", "starting setup")
	util.Download(myzsPath, myzsLink)
	_, err := util.Unzip(myzsPath, myzsTemp)
	if err != nil {
		util.GetLogger().WithError(err).Fatal("unzip", "err")
	}

	client.ExecShellScript(myzsTemp + "/myzs-master/install.sh")
}
