package scad

import (
	"github.com/leocov-dev/go-scad-render/config"
	"os"
	"path"
	"path/filepath"
	"strings"
)

type File struct {
	FullPath string
	Dir      string
	Filename string
}

func NewFile(filePath string) *File {
	dir, file := path.Split(filePath)
	filename := strings.TrimSuffix(file, path.Ext(file))

	fileStruct := &File{
		FullPath: filePath,
		Dir:      dir,
		Filename: filename,
	}

	return fileStruct
}

func FilterFiles(files []*File, filterFn func(f *File) (bool, error)) (filtered []*File, err error) {

	for _, f := range files {
		keep, err := filterFn(f)
		if err != nil {
			return nil, err
		}

		if keep {
			filtered = append(filtered, f)
		}
	}

	return filtered, nil
}

func GatherScadFiles(scanDir string) (files []*File, err error) {
	if scanDir == "" {
		scanDir = config.ExecDir
	}

	err = filepath.WalkDir(
		scanDir,
		func(fp string, info os.DirEntry, err error) error {
			if err != nil {
				return err
			}

			if path.Base(info.Name()) == "lib" {
				return filepath.SkipDir
			}

			if path.Ext(info.Name()) == ".scad" && !strings.HasPrefix(info.Name(), "lib_") {
				files = append(files, NewFile(fp))
			}
			return nil
		},
	)

	return files, err
}
