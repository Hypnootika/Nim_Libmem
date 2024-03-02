import futhark, os, strutils, winim


proc renameCb(n, k: string, p = ""): string =
  n.replace("LM_", "").replace("lm_", "")


importc:
  outputPath currentSourcePath.parentDir / "generated.nim"
  path "Libmem"
  renameCallback renameCb
  "libmem.h"


# var p: processt
# var status = Getprocess(p.addr)
# echo status
# echo "Process ID: ", p.pid, " Process Name: ", p.name
