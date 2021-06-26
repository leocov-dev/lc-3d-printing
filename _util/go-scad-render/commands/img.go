package commands

import (
	"fmt"
	"github.com/leocov-dev/go-scad-render/config"
	"github.com/leocov-dev/go-scad-render/internal/scad"
	"github.com/leocov-dev/go-scad-render/internal/utils"
	"github.com/leocov-dev/go-scad-render/internal/utils/spinners"
	"github.com/spf13/cobra"
	"strings"
)

var (
	imgCmd = &cobra.Command{
		Use:   "img",
		Short: "Render as images",
		Run:   run,
		PreRun: func(cmd *cobra.Command, args []string) {
			utils.CloseHandler()
		},
	}

	onlyMissing bool
)

func init() {
	imgCmd.Flags().BoolVarP(&onlyMissing, "onlyMissing", "m", false, "Only render missing images.")

	imgCmd.Flags().VarP(
		config.ConcurrencyLimitValue,
		"concurrency",
		"c",
		fmt.Sprintf("The number of simultaneous renders allowed - defaults to # cores"),
	)

	rootCmd.AddCommand(imgCmd)
}

func run(cmd *cobra.Command, _ []string) {
	note := "\n"
	if onlyMissing {
		note = "Only missing images\n"
	}

	s := spinners.StartNewSpinner(fmt.Sprintf("Scanning for OpenScad files in: %s...", config.ExecDir))
	files, err := scad.GatherScadFiles()
	if err != nil {
		utils.CmdFailed(cmd, err)
	}
	s.Stop()

	if config.DebugMode {
		utils.WriteMain("Files to Render", note+strings.Join(files, "\n"))
	}

	s = spinners.StartNewSpinner("Rendering...")

	err = scad.RenderImages(files)
	if err != nil {
		utils.CmdFailed(cmd, err)
	}
	s.Stop()
}
