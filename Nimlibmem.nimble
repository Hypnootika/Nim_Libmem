# Package

version       = "0.1.0"
author        = "Hypnootika"
description   = "Nim bindings for Libmem"
license       = "MIT"
srcDir        = "src"
skipDirs      = @["tests", "examples", "docs"]
# Dependencies

requires "nim >= 2.0.0, winim, futhark, memlib"

task generate_wrapper, "Build the project":
  withDir "src":
   exec "nim c -c -d:danger --opt:size --nomain --cpu:amd64 nimlibmem.nim"
   exec "python ../release/clean_generated_file.py"

task runtests, "Run the tests":
  withDir "tests":
    exec "nim c -r test_nimlibmem.nim"
    exec "cmd /k DEL test_nimlibmem.exe"