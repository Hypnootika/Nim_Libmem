# Package

version       = "0.1.0"
author        = "Hypnootika"
description   = "Nim bindings for Libmem"
license       = "MIT"
srcDir        = "src"
skipDirs      = @["tests", "examples", "docs"]
# Dependencies

requires "nim >= 2.0.0, winim, futhark, memlib"

task build, "Build the project":
  withDir "src":
   exec "nim c -d:danger --opt:size --nomain --app:lib --cpu:amd64 src/nimlibmem.nim"