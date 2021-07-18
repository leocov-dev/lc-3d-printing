package config

import (
	"context"
	"github.com/leocov-dev/go-scad-render/internal/cli"
	"os"
	"runtime"
)

var (
	Version     string // NOTE: set by build args
	Name        = "scad-render"
	PngTemplate = `{{.Dir}}{{.Filename}}.scad --autocenter --viewall --imgsize {{.ImgSize}},{{.ImgSize}} --render --o {{.Dir}}{{.Filename}}.png -D '$fn={{.Precision}}'`
	StlTemplate = `{{.Dir}}{{.Filename}}.scad --autocenter --viewall --render --o {{.Dir}}stl/{{.Filename}}.stl -D '$fn={{.Precision}}'`
	ExecDir, _  = os.Getwd()

	CancelRender          context.CancelFunc
	CTX                   context.Context
	defaultConcurrency    = runtime.NumCPU()
	ConcurrencyLimit      int
	ConcurrencyLimitValue = cli.NewConcurrencyValue(defaultConcurrency, &ConcurrencyLimit)
	DebugMode             bool
	OnlyRenderMissing     bool
)

func init() {
	CTX, CancelRender = context.WithCancel(context.Background())
}
