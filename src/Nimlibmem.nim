import futhark, os, strutils, winim


proc renameCb(n, k: string, p = ""): string =
  n.replace("LM_", "").replace("lm_", "")

# macro customPragma(msg: static[string], body: untyped): untyped =
  #   echo "Saying: ", msg
  #   return body
# Above macro needs to get changes so the current standard:
  # {.cdecl, importc: "LM_EnumThreads".}
# changes to the following:
  # {.cdecl, dynlib: libname, importc: "LM_EnumThreads".}

macro custompragma(msg: static[string], body: untyped): untyped =
  echo msg
  return body

importc:
  outputPath currentSourcePath.parentDir / "generated.nim"
  path "Libmem"
  forward "GetProcess", customPragma("Hello world"), used

  renameCallback renameCb
  "libmem.h"


# var p: processt
# var status = Getprocess(p.addr)
# echo status
# echo "Process ID: ", p.pid, " Process Name: ", p.name
