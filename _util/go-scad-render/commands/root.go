package commands

import (
	"fmt"
	"github.com/leocov-dev/go-scad-render/config"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var (
	rootCmd = &cobra.Command{
		Use: config.Name,
		Long: fmt.Sprintf("%s %s\nRender OpenSCAD files as stl or png",
			config.Name,
			config.Version),
		PersistentPreRun: func(cmd *cobra.Command, args []string) {
			setLoggingLevel()
		},
	}
)

func init() {
	rootCmd.PersistentFlags().BoolVarP(&config.DebugMode, "debug", "d", false, "Print additional debug and informational logs.")
	_ = rootCmd.PersistentFlags().MarkHidden("debug")
}

func Execute() {
	_ = rootCmd.Execute()
}

func setLoggingLevel() {
	if config.DebugMode {
		log.SetLevel(log.DebugLevel)
		fmt.Println("*** In Debug Mode ***")
		fmt.Println()
	} else {
		log.SetLevel(log.WarnLevel)
	}
}
