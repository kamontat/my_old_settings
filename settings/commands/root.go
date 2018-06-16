// Copyright © 2018 Kamontat Chantrachirathumrong <kamontat.c@hotmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

package command

import (
	"fmt"
	"os/user"

	util "github.com/kamontat/my_settings/settings/utils"
	"github.com/matishsiao/goInfo"
	homedir "github.com/mitchellh/go-homedir"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var username string
var shellname string
var email string
var noInternet bool
var os string

// 1. settings quick-setup|quick [--opt]
// 2. settings full-setup|full [--opt]

// Full-setup parameters

// 1. --settings         -- for computer settings
// 2. --application      -- for application
// 3. --font             -- for setup font
// 4. --only-application -- for input application category

// Global parameters

// 1. --user        - username (default=whoami)
// 2. --email       - apple id
// 3. --shell       - shell (default=bash)
// 4. --no-internet - pass operation that require network

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "settings",
	Short: "New computer setup script",
	Long: `This script made by golang, which able to compile cross-platform. 
For command usage, I built follow cobra concept (https://github.com/spf13/cobra#concepts).
This allow you to quick setup your new computer within 3 second or even have full setup in your computer.

To setting configuration, you able to use any flag that available or configuration file at '$HOME/.mys/config.properties'
  `,
	Version: util.VERSION_DEFAULT_FORMAT.GetResult(),
}

var vp = viper.New()

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		util.GetLogger().WithError(err).Error("Execute", "root command execute error")
		// os.Exit(1)
	}
}

func init() {
	cobra.OnInitialize(initConfig, initLogger)
	user, err := user.Current()
	if err != nil {
		util.GetLogger().WithError(err).Error("User", "cannot get current user")
		// os.Exit(1)
	}

	gi := goInfo.GetInfo()

	rootCmd.PersistentFlags().StringVarP(&username, "username", "U", user.Username, "username for some for commands")
	rootCmd.PersistentFlags().StringVarP(&shellname, "shell", "S", "bash", "shellname for setup terminal")
	rootCmd.PersistentFlags().StringVarP(&email, "email", "E", "", "Apple ID Email for install app mac store")
	rootCmd.PersistentFlags().StringVarP(&os, "os", "P", gi.OS, "Current OS/Platform")
	rootCmd.PersistentFlags().BoolVarP(&noInternet, "no-internet", "n", false, "Bypass all command that require internet")
}

// initConfig reads in config file and ENV variables if set.
func initConfig() {
	// Find home directory.
	home, err := homedir.Dir()
	if err != nil {
		util.GetLogger().WithError(err).Error("Directory", "cannot get directory")
		// os.Exit(1)
	}

	// Search config in home directory with name ".settings" (without extension).
	vp.SetConfigType("yaml")
	vp.SetConfigName("config")

	vp.AddConfigPath(home + "/.mys")
	vp.AddConfigPath("./.mys")

	vp.SetEnvPrefix("mys")
	vp.AutomaticEnv() // read in environment variables that match

	// If a config file is found, read it in.
	err = vp.ReadInConfig()
	if err == nil {
		util.GetLogger().Debug("Config file", vp.ConfigFileUsed())
	} else {
		fmt.Println(err)
	}

	if username == "" {
		username = vp.GetString("username")
	}
	if shellname == "" {
		shellname = vp.GetString("shellname")
	}
	if email == "" {
		email = vp.GetString("email")
	}
	if os == "" {
		os = vp.GetString("os")
	}
}

func initLogger() {
	util.Init(vp)
}
