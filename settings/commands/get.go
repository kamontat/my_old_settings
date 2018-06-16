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

	"github.com/sirupsen/logrus"

	util "github.com/kamontat/my_settings/settings/utils"
	"github.com/spf13/cobra"
)

var allArgument = []string{
	"username",
	"shellname",
	"email",
	"os",
	"internet",
}

var mainArgument = []string{
	"username",
	"shellname",
	"email",
	"os",
	"internet",
	"all",
	"help",
}

var availableArgument = []string{
	"username", "user", "U",
	"shellname", "shell", "S",
	"email", "mail", "E",
	"os", "P",
	"internet", "net", "I",
	"all", "A",
	"",
	"help", "H",
}

// getCmd represents the get command
var getCmd = &cobra.Command{
	Use:   "get",
	Short: "Getting command for lookup that your configuration are completed or not",
	Long: `The getting accept only arguments. 

#01 Case: no argument
  the application will act like 'all' is passed
#02 Case: 1 argument or more
  the application will loop all argument and print the result list
#03 Case: 1 argument and that is 'all'
  this application will list all possible result
#04 Case: 1 argument and that is 'help'
  the application will show the avaliable list of argument

Available arguments list
  [
    username  user  U -- get username 
    shellname shell S -- get shellname
    email     mail  E -- get email    
    os              P -- get OS 
    internet  net   I -- check is internet exist 
    all             A -- list all argument result
    help            H -- show available list
  ]
  `,
	ValidArgs: availableArgument,
	Args: func(cmd *cobra.Command, args []string) (err error) {
		err = cobra.OnlyValidArgs(cmd, args)
		if err != nil {
			return fmt.Errorf("%s: \nAvailable list: %s", err, allArgument)
		}
		return
	},
	Run: func(cmd *cobra.Command, args []string) {
		result := "unknown"

		if len(args) == 0 || args[0] == "all" {
			args = allArgument
		}

		for index, element := range args {
			switch element {
			case "username", "user", "U":
				result = username
			case "shellname", "shell", "S":
				result = shellname
			case "email", "mail", "E":
				result = email
			case "os", "P":
				result = os
			case "internet", "net", "I":
				result = util.ReportConnection()
			case "help", "H":
				result = fmt.Sprintf("Available list: %s", mainArgument)
			}

			util.GetLogger().WithField(logrus.Fields{"index": index + 1}).Log(element, result)
		}
	},
}

func getUsername() {
	fmt.Println("My username is " + username)
}

func init() {
	rootCmd.AddCommand(getCmd)
}
