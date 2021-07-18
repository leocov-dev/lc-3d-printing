package scad

import (
	"errors"
	"fmt"
	"github.com/gosuri/uiprogress"
	"github.com/leocov-dev/go-scad-render/config"
	"github.com/leocov-dev/go-scad-render/internal/utils"
	concurrent_pool "github.com/leocov-dev/go-scad-render/pkg/concurrent_tasks"
	"os/exec"
	"strings"
	"text/template"
	"time"
)

type ImgTemplateData struct {
	Filename  string
	ImgSize   uint
	Dir       string
	Precision uint8
}

func execOpenScadRender(file File, size uint, precision uint8) error {

	time.Sleep(1 * time.Second)

	cmd := exec.Command(
		"openscad",
		file.FullPath,
		"--render",
		"--autocenter",
		"--viewall",
		"--imgsize",
		fmt.Sprintf("%d,%d", size, size),
		"-D",
		fmt.Sprintf("$fn=%d", precision),
		"-o",
		fmt.Sprintf("%s%s.png", file.Dir, file.Filename),
	)
	err := cmd.Run()
	if err != nil {
		return errors.New(fmt.Sprintf("%s: %s", file.Filename, err.Error()))
	}
	return nil
}

func RenderImages(scadFiles []*File, size uint, precision uint8, progressBar *uiprogress.Bar) ([]string, error) {

	argsTemplate, err := template.New("png").Parse(config.PngTemplate)
	if err != nil {
		return nil, err
	}

	var argsList []string

	for _, sf := range scadFiles {
		scadImage := ImgTemplateData{
			sf.Filename,
			size,
			sf.Dir,
			precision,
		}
		var buf strings.Builder
		err = argsTemplate.Execute(&buf, scadImage)
		if err != nil {
			return nil, err
		}

		argsList = append(argsList, buf.String())
	}

	if config.DebugMode {
		fmt.Println("\n------")
		utils.WriteMain("Commands to Run", "\n"+strings.Join(argsList, "\n"))
		fmt.Println("------\n")
	}

	procPool := concurrent_pool.NewPool(config.ConcurrencyLimit, true)

	for _, scad := range scadFiles {
		s := *scad
		proc := concurrent_pool.NewProc(
			func() error {
				return execOpenScadRender(s, size, precision)
			},
			func() {
				if progressBar != nil {
					progressBar.Incr()
				}
			},
			nil,
			config.CTX,
			config.CancelRender,
		)

		procPool.Add(proc)
	}

	saveErrors := procPool.Process()

	return saveErrors, nil
}
