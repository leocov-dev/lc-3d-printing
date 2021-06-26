package scad

import (
	"github.com/leocov-dev/go-scad-render/config"
	"github.com/leocov-dev/go-scad-render/internal/utils"
	"path"
	"strings"
	"text/template"
)

type ImgTemplateData struct {
	Filename  string
	ImgSize   int
	Dir       string
	Precision int8
}

func RenderImages(scadFiles []string) error {

	cmdTemplate, err := template.New("png").Parse(config.PngTemplate)
	if err != nil {
		return err
	}

	var cmds []string

	for _, sf := range scadFiles {
		dir, file := path.Split(sf)
		filename := strings.TrimSuffix(file, path.Ext(file))

		scadImage := ImgTemplateData{
			filename,
			512,
			dir,
			32,
		}
		var buf strings.Builder
		err = cmdTemplate.Execute(&buf, scadImage)
		if err != nil {
			return err
		}

		cmds = append(cmds, buf.String())
	}

	if config.DebugMode {
		utils.WriteMain("Commands to Run", "\n"+strings.Join(cmds, "\n"))
	}

	return nil
}
