package util

import (
	"fmt"
	"os"

	survey "gopkg.in/AlecAivazis/survey.v1"
)

// PromptYesNo to prompt yes/no question, this title will be "Do you want '<key>' ? [y|N]"
func PromptYesNo(defaultValue bool, msg string, help string) (result bool) {
	prompt := &survey.Confirm{
		Message: fmt.Sprintf("Do you want '%-26s'? : ", msg),
		Default: defaultValue,
		Help:    help,
	}
	err := survey.AskOne(prompt, &result, nil)
	if err != nil {
		fmt.Println(err)
		os.Exit(127)
	}
	return
}

// PromptWithValue input result variable, and prompt to user and than save result to variable
//    This title should be Enter <key>: (<default>)
func PromptWithValue(result *string, defaultValue string, msg string, help string) {
	prompt := &survey.Input{
		Message: fmt.Sprintf("Enter  %-35s: ", msg),
		Default: defaultValue,
		Help:    help,
	}
	err := survey.AskOne(prompt, result, nil)
	if err != nil {
		fmt.Println(err)
		os.Exit(127)
	}
	return
}

// PromptChooseWithValue input result variable, and list of choice prompt, wait user to select and save to input variable
//    This title should be Choose <key>:
func PromptChooseWithValue(result *string, list []string, defaultValue string, msg string, help string) {
	prompt := &survey.Select{
		Message: fmt.Sprintf("Choose %-35s: ", msg),
		Options: list,
		Help:    help,
		Default: defaultValue,
	}
	err := survey.AskOne(prompt, result, nil)
	if err != nil {
		fmt.Println(err)
		os.Exit(127)
	}
}
