## This is a test for the functions imported from Libmem.h
import strutils, winim/winstr
include  ../release/nimlibmem

const
  testProcess = "notepad.exe"

var notepad_check: bool = false

var
  p2: processt
  processList: seq[processt]
  pprocess: processt
  threadList: seq[threadt]
  pthread: threadt
  threadList2: seq[threadt]
  pthread2: threadt
  moduleList: seq[modulet]
  pmodule: modulet
  symbol: symbolt
  symbolList: seq[symbolt]



proc enumProcessCallback(pproc: ptr processt, arg: pointer): boolt {.cdecl.} =
  processList.add(pproc[])
  result = boolt.True

proc enumThreadCallback(pthread: ptr threadt, arg: pointer): boolt {.cdecl.} =
  threadList.add(pthread[])
  result = boolt.True

proc enumThreadCallback2(pthread2: ptr threadt, arg: pointer): boolt {.cdecl.} =
  threadList2.add(pthread2[])
  result = boolt.True

proc enumModuleCallback(pmodule: ptr modulet, arg: pointer): boolt {.cdecl.} =
  moduleList.add(pmodule[])
  result = boolt.True

proc enumSymbolCallback(psymbol: ptr symbolt, arg: pointer): boolt {.cdecl.} =
  symbolList.add(psymbol[])
  result = boolt.True

proc printProcessInfo(prefix: string, p: processt) =
  echo prefix, "Process ID: ", p.pid,
      "\n", prefix, "Process Name: ", nullTerminated($$p.name),
      "\n", prefix, "Process bits: ", p.bits,
      "\n", prefix, "Process Start Time: ", p.starttime,
      "\n", prefix, "Process Path: ", nullTerminated($$p.path)

proc printModuleInfo(prefix: string, m: modulet) =
  echo prefix, "Module Name: ", nullTerminated($$m.name),
      "\n", prefix, "Module Path: ", nullTerminated($$m.path),
      "\n", prefix, "Module Base: ", m.base,
      "\n", prefix, "Module Size: ", m.size

proc printThreadInfo(prefix: string, t: threadt) =
  echo prefix, "Thread ID: ", t.tid,
      "\n", prefix, "Thread Owner Process ID: ", t.ownerpid

proc printSymbolInfo(prefix: string, s: symbolt) =
  echo prefix, "Symbol Name: ", nullTerminated($$s.name),
    "\n", prefix, "Symbol Address: ", s.repr

proc testGetProcess() =
  var p: processt
  let status = Getprocess(p.addr)
  assert status == enumboolt.True, "Getprocess failed."
  printProcessInfo("Getprocess: ", p)

testGetProcess()

proc testFindProcess() =
  var p: processt
  let status = Findprocess(testProcess, p.addr)
  assert cast[bool](status), "Findprocess failed."
  printProcessInfo("Findprocess: ", p)

testFindProcess()

proc testGetProcessEx() =
  var p: processt
  let status = Getprocess(p.addr)
  let status2 = Getprocessex(p.pid, p.addr)
  assert cast[bool](status2), "Getprocessex failed."
  assert cast[bool](status), "Getprocess failed."
  printProcessInfo("Getprocessex: ", p)

testGetProcessEx()

proc isProcessAlive() =
  var p: processt
  let status = Getprocess(p.addr)
  assert cast[bool](status), "Getprocess failed."
  let alive = Isprocessalive(p.addr)
  echo "Isprocessalive: ", alive
  assert cast[bool](alive), "Isprocessalive failed."

isProcessAlive()

proc testGetProcessBits() =
  let bits = Getsystembits()
  echo "Getsystembits: ", bits
  assert bits == 64, "Getprocessbits failed."

testGetProcessBits()

proc testGetThread() =
  var t: threadt
  let status = Getthread(t.addr)
  assert cast[bool](status), "Getthread failed."
  printThreadInfo("Getthread: ", t)

testGetThread()

proc testGetThreadEx() =
  var p: processt
  var t: threadt
  let status = Getprocess(p.addr)
  let status2 = Getthreadex(p.addr, t.addr)
  assert cast[bool](status2), "Getthreadex failed."
  assert cast[bool](status), "Getthread failed."
  printThreadInfo("Getthreadex: ", t)

testGetThreadEx()

proc testGetThreadProcess() =
  var t: threadt
  let status = Getthread(t.addr)
  let status2 = Getthreadprocess(t.addr, p2.addr)
  assert cast[bool](status2), "Getthreadprocess failed."
  assert cast[bool](status), "Getthread failed."
  printProcessInfo("Getthreadprocess: ", p2)

testGetThreadProcess()

proc EnumprocessesTest() =
  var status: boolt = Enumprocesses(enumProcessCallback, nil)
  assert cast[bool](status), "Enumprocesses failed."
  assert processList.len > 0, "Enumprocesses failed."
  for p in processList:
    printProcessInfo("Enumprocesses: ", p)

EnumprocessesTest()

proc EnumthreadsTest() =
  var status: boolt = Enumthreads(enumThreadCallback, nil)
  assert cast[bool](status), "Enumthreads failed."
  assert threadList.len > 0, "Enumthreads failed."
  for t in threadList:
    printThreadInfo("Enumthreads: ", t)

EnumthreadsTest()

proc EnumThreadsExTest() =
  var p: processt = processList[0]
  var status: boolt = Enumthreadsex(p.addr, enumThreadCallback2, nil)
  assert cast[bool](status), "Enumthreadsex failed."
  assert threadList2.len > 0, "Enumthreadsex failed."
  for t in threadList2:
    printThreadInfo("Enumthreadsex: ", t)

EnumThreadsExTest()

proc EnumModulesTest() =
  var status: boolt = Enummodules(enumModuleCallback, nil)
  assert cast[bool](status), "Enummodules failed."
  assert moduleList.len > 0, "Enummodules failed."
  for m in moduleList:
    printModuleInfo("Enummodules: ", m)

EnumModulesTest()

proc testFindModule() =
  const test_module = "ntdll.dll"
  var m: modulet
  let status = Findmodule(test_module, m.addr)
  assert cast[bool](status), "Findmodule failed."
  printModuleInfo("Findmodule: ", m)

testFindModule()

proc testFindModuleEx() =
  const test_module = "ntdll.dll"
  var p: processt
  var m: modulet
  let status = Findmodule(test_module, m.addr)
  assert cast[bool](status), "Findmodule failed."
  printModuleInfo("Findmodule: ", m)
  let status2 = Findmoduleex(p.addr, test_module, m.addr)
  assert cast[bool](status2), "Findmoduleex failed."
  printModuleInfo("Findmoduleex: ", m)

testFindModuleEx()

proc testLoadModule() =
  const test_module = "ntdll.dll"
  var m: modulet
  let status = Loadmodule(test_module, m.addr)
  assert cast[bool](status), "Loadmodule failed."
  printModuleInfo("Loadmodule: ", m)

testLoadModule()

proc testUnloadModule() =
  const test_module = "ntdll.dll"
  var m: modulet
  let status = Loadmodule(test_module, m.addr)
  assert cast[bool](status), "Loadmodule failed."
  printModuleInfo("Loadmodule: ", m)
  let status2 = Unloadmodule(m.addr)
  assert cast[bool](status2), "Unloadmodule failed."

## Not implemented yet
# testUnloadModule()
#
# proc testUnloadModuleEx() =
#   const test_module = "C:\\Windows\\System32\\ntdll.dll"
#   var pl: processt
#   var ml: modulet
#   let status = Findprocess(testProcess, pl.addr)
#   assert cast[bool](status), "Getprocess failed."
#   let status2 = Loadmoduleex(pl.addr, test_module, ml.addr)
#   assert cast[bool](status2), "Loadmodule failed."
#   printModuleInfo("Loadmodule: ", ml)
#   let status3 = Unloadmoduleex(pl.addr, ml.addr)
#   assert cast[bool](status3), "Unloadmoduleex failed."
#
# testUnloadModuleEx()

## Not implemented yet
# proc testEnumSymbols() =
#   var module = moduleList[0]
#   var status: boolt = Enumsymbols(module.addr, enumSymbolCallback, nil)
#   assert cast[bool](status), "Enumsymbols failed."
#   assert symbolList.len > 0, "Enumsymbols failed."
#   for s in symbolList:
#     printSymbolInfo("Enumsymbols: ", s)
#
# testEnumSymbols()

## Not implemented yet
# proc testFindSymbolAddress() =
#   var module = moduleList[0]
#   var symbol_name = "NtCreateFile"
#   let status = Findsymboladdress(module.addr, symbol_name)
#   assert status != 0, "Findsymboladdress failed."
#   echo "Findsymboladdress: ", status
#
# testFindSymbolAddress()

## Not implemented yet
# proc testDemangleSymbol() =
#   var symbol_name = "NtCreateFile"
#   var demangled_buf: cstring
#   let status = Demanglesymbol(symbol_name, demangled_buf, 1024)
#   assert status.len > 0, "Demanglesymbol failed."
#   echo "Demanglesymbol: ", status
#
# testDemangleSymbol()

## Not implemented yet
# proc testFreeDemangleSymbol() =
#   var symbol_name = "NtCreateFile"
#   let status = Freedemanglesymbol(symbol_name)
#   assert status == enumboolt.True, "Freedemanglesymbol failed."
#
# testFreeDemangleSymbol()

## Not implemented yet
# proc testEnumSymbolsDemangled() =
#   var module = moduleList[0]
#   var status: boolt = Enumsymbolsdemangled(module.addr, enumSymbolCallback, nil)
#   assert cast[bool](status), "Enumsymbolsdemangled failed."
#   assert symbolList.len > 0, "Enumsymbolsdemangled failed."
#   for s in symbolList:
#     printSymbolInfo("Enumsymbolsdemangled: ", s)
#
# testEnumSymbolsDemangled()

## Not implemented yet
# proc testFindSymbolAddressDemangled() =
#   var module = moduleList[0]
#   var symbol_name = "NtCreateFile"
#   let status = Findsymboladdressdemangled(module.addr, symbol_name)
#   assert status != 0, "Findsymboladdressdemangled failed."
#   echo "Findsymboladdressdemangled: ", status
#
# testFindSymbolAddressDemangled()
