import futhark, os, strutils, winim, osproc


proc renameCb(n, k: string, p = ""): string =
  n.replace("LM_", "").replace("lm_", "")


importc:
  outputPath currentSourcePath.parentDir / "../release/nimlibmem.nim"
  path "Libmem"
  renameCallback renameCb
  "libmem.h"


proc runPythonScript(script: string): string =
  result = execProcess("python " & script)



sleep(1000)
echo runPythonScript("release/clean_generated_file.py")

