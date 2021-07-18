# scad-render

A CLI utility to batch render scad files in various formats

### Supported Output Formats
* STL - 3d printing
* PNG - image

## Install
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/leocov-dev/go-scad-render)](https://github.com/leocov-dev/go-scad-render/releases/latest)

Get [latest](https://github.com/leocov-dev/go-scad-render/releases/latest) prebuilt executable from the [releases](https://github.com/leocov-dev/go-scad-render/releases) page.

### Dependencies

* Go - 1.16.x

### Development

Install the Go version defined in [go.mod](https://github.com/leocov-dev/go-scad-render/blob/main/go.mod) or use [goenv](https://github.com/syndbg/goenv) to manage Go (as set by `.go-version`).


```
# build for your platform only and run.
$ make && bin/scad-render --help
```

### Notes
Some scad files are complex and may take a very long time to render, especially at higher precision levels.
The progress indicator updates when a file is complete NOT during file rendering.
This may give the false impression that the utility has crashed or stopped working.
