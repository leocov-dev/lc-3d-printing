package config

import (
	"context"
	"github.com/leocov-dev/go-scad-render/internal/cli"
	"os"
	"runtime"
)

var (
	Version     string // set by build args
	Name        = "go-scad-render"
	PngTemplate = `openscad {{.Filename}}.scad --autocenter --viewall --imgsize {{.ImgSize}},{{.ImgSize}} --render --o {{.Dir}}{{.Filename}}.png -D '$fn={{.Precision}}'`
	StlTemplate = `openscad {{.Filename}}.scad --autocenter --viewall --render --o {{.Dir}}stl/{{.Filename}}.stl -D '$fn={{.Precision}}'`
	ExecDir, _  = os.Getwd()

	CTX, CancelRender     = context.WithCancel(context.Background())
	defaultConcurrency    = runtime.NumCPU()
	ConcurrencyLimit      int
	ConcurrencyLimitValue = cli.NewConcurrencyValue(defaultConcurrency, &ConcurrencyLimit)
	DebugMode             bool
)
