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

task buildpy, "Build the python wrapper":
  withDir "src":
    switch("passC", "-s -w -flto -ffast-math -fsingle-precision-constant -static")
    switch("passL", "-s -w -flto -ffast-math -fsingle-precision-constant -static")
    switch("tlsEmulation", "off")
    switch("out", "nimlibmem.pyd")
    exec "nim c --cpu:amd64 --app:lib --out:convenience_layer.pyd --threads:on --tlsEmulation:off --passL:-static ../release/convenience_layer.nim"
