package util

import (
	"fmt"
	"os"

	survey "gopkg.in/AlecAivazis/survey.v1"
)

var bypassPrompt = false

func InitialPrompt(bypass bool) {
	bypassPrompt = bypass
}

func isBypassPrompt(message string, defaultValue string) bool {
	if bypassPrompt {
		GetLogger().Info("Prompt", message+defaultValue)
	}
	return bypassPrompt
}

func toString(b bool) string {
	if b {
		return "true"
	}
	return "false"
}

// PromptYesNo to prompt yes/no question, this title will be "Do you want '<key>' ? [y|N]"
func PromptYesNo(defaultValue bool, msg string, help string) (result bool) {
	message := fmt.Sprintf("Do you want '%-26s'? : ", msg)
	if isBypassPrompt(message, toString(defaultValue)) {
		return defaultValue
	}

	prompt := &survey.Confirm{
		Message: message,
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

// PromptYesNoWithValue to prompt yes/no question, and save result to input variable
func PromptYesNoWithValue(result *string, defaultValue bool, msg string, help string) {
	message := fmt.Sprintf("Do you want '%-26s'? : ", msg)
	if isBypassPrompt(message, toString(defaultValue)) {
		*result = fmt.Sprintf("%t", defaultValue)
		return
	}

	comfirm := false
	comfirmAsString := "false"
	prompt := &survey.Confirm{
		Message: message,
		Default: defaultValue,
		Help:    help,
	}
	err := survey.AskOne(prompt, &comfirm, nil)
	if err != nil {
		fmt.Println(err)
		os.Exit(127)
	}
	comfirmAsString = fmt.Sprintf("%t", comfirm)
	*result = comfirmAsString
	return
}

// PromptWithValue input result variable, and prompt to user and than save result to variable
//    This title should be Enter <key>: (<default>)
func PromptWithValue(result *string, defaultValue string, msg string, help string) {
	message := fmt.Sprintf("Enter  %-35s: ", msg)
	if isBypassPrompt(message, defaultValue) {
		*result = defaultValue
		return
	}
	prompt := &survey.Input{
		Message: message,
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
	message := fmt.Sprintf("Choose %-35s: ", msg)

	if isBypassPrompt(message, defaultValue) {
		*result = defaultValue
		return
	}

	prompt := &survey.Select{
		Message: message,
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
