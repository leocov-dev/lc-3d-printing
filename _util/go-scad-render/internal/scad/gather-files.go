package scad

import (
	"github.com/leocov-dev/go-scad-render/config"
	"os"
	"path"
	"path/filepath"
	"strings"
)

func GatherScadFiles() (files []string, err error) {
	err = filepath.WalkDir(config.ExecDir,
		func(fp string, info os.DirEntry, err error) error {
			if err != nil {
				return err
			}

			if path.Base(info.Name()) == "lib" {
				return filepath.SkipDir
			}

			if path.Ext(info.Name()) == ".scad" && !strings.HasPrefix(info.Name(), "lib_") {
				files = append(files, fp)
			}
			return nil
		},
	)

	return files, err
}
