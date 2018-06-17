package setup

import (
	client "github.com/kamontat/my_settings/settings/clients"
	util "github.com/kamontat/my_settings/settings/utils"
)

const MYZS_PATH = "/tmp/myzs.zip"
const MYZS_RESULT = "/tmp/myzs.temp"
const MYZS_LINK = "https://github.com/kamontat/myzs/archive/master.zip"

func ZshSetup() {
	util.GetLogger().Debug("Zsh", "starting setup")
	util.Download(MYZS_PATH, MYZS_LINK)
	_, err := util.Unzip(MYZS_PATH, MYZS_RESULT)
	if err != nil {
		util.GetLogger().WithError(err).Fatal("unzip", "err")
	}

	client.ExecShellScript(MYZS_RESULT + "/myzs-master/install.sh")
}
