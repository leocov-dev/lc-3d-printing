# 3D Print Files

A collection of OpenSCAD files of 3D printable objects.

Each `.scad` file should have an accompanying image to show its contents. 

These are for various personal projects and ideas. 
They might NOT be "print ready" - their orientation and composition in the `.scad` files may need adjustment for a successful print.

### Lib

The `/lib` directory contains various utility modules and functions. 
It also includes git submodules for [BOSL](https://github.com/revarbat/BOSL) and [BOSL2](https://github.com/revarbat/BOSL2) for convenience.

### Utils

The `_util` directory contains non-scad utils.

The `/_util/go-scad-render` directory contains a Golang project for rendering images and stl's of all the scad files in this repo.
To access this functionality conveniently execute `bin/render` bash script (must already have Go installed).
