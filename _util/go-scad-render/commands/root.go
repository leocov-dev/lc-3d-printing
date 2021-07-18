package commands

import (
	"fmt"
	"github.com/leocov-dev/go-scad-render/config"
	"github.com/leocov-dev/go-scad-render/internal/utils"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var (
	rootCmd = &cobra.Command{
		Use: config.Name,
		Long: fmt.Sprintf("%s %s\nRender OpenSCAD files in various formats",
			config.Name,
			config.Version),
		PersistentPreRun: func(cmd *cobra.Command, args []string) {
			setLoggingLevel()
			utils.CloseHandlerWithCallback(func() {
				config.CancelRender()
			})
		},
	}
)

func init() {
	rootCmd.PersistentFlags().BoolVarP(
		&config.DebugMode,
		"debug",
		"d",
		false,
		"Print additional debug and informational logs.",
	)
	_ = rootCmd.PersistentFlags().MarkHidden("debug")

	rootCmd.PersistentFlags().BoolVarP(
		&config.OnlyRenderMissing,
		"onlyMissing",
		"m",
		false,
		"Only render missing images.",
	)

	rootCmd.PersistentFlags().VarP(
		config.ConcurrencyLimitValue,
		"concurrency",
		"c",
		fmt.Sprintf("The number of simultaneous renders allowed"),
	)
}

func Execute() {
	_ = rootCmd.Execute()
}

func setLoggingLevel() {
	if config.DebugMode {
		log.SetLevel(log.DebugLevel)
		fmt.Println("\n*** In Debug Mode ***")
		fmt.Println()
	} else {
		log.SetLevel(log.WarnLevel)
	}
}
