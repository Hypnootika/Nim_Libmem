## This is a test for the functions imported from Libmem.h
import strutils, winim/winstr
include  ../release/nimlibmem
import sequtils, sugar, strformat
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
  segment: segmentt
  segmentList: seq[segmentt]
  bbytet: bytet
  buffer: seq[bytet]


var buf: array[306, bytet] = [
byte 0xfc,0x48,0x81,0xe4,0xf0,0xff,0xff,0xff,0xe8,0xd0,0x00,
0x00,0x00,0x41,0x51,0x41,0x50,0x52,0x51,0x56,0x48,0x31,0xd2,
0x65,0x48,0x8b,0x52,0x60,0x3e,0x48,0x8b,0x52,0x18,0x3e,0x48,
0x8b,0x52,0x20,0x3e,0x48,0x8b,0x72,0x50,0x3e,0x48,0x0f,0xb7,
0x4a,0x4a,0x4d,0x31,0xc9,0x48,0x31,0xc0,0xac,0x3c,0x61,0x7c,
0x02,0x2c,0x20,0x41,0xc1,0xc9,0x0d,0x41,0x01,0xc1,0xe2,0xed,
0x52,0x41,0x51,0x3e,0x48,0x8b,0x52,0x20,0x3e,0x8b,0x42,0x3c,
0x48,0x01,0xd0,0x3e,0x8b,0x80,0x88,0x00,0x00,0x00,0x48,0x85,
0xc0,0x74,0x6f,0x48,0x01,0xd0,0x50,0x3e,0x8b,0x48,0x18,0x3e,
0x44,0x8b,0x40,0x20,0x49,0x01,0xd0,0xe3,0x5c,0x48,0xff,0xc9,
0x3e,0x41,0x8b,0x34,0x88,0x48,0x01,0xd6,0x4d,0x31,0xc9,0x48,
0x31,0xc0,0xac,0x41,0xc1,0xc9,0x0d,0x41,0x01,0xc1,0x38,0xe0,
0x75,0xf1,0x3e,0x4c,0x03,0x4c,0x24,0x08,0x45,0x39,0xd1,0x75,
0xd6,0x58,0x3e,0x44,0x8b,0x40,0x24,0x49,0x01,0xd0,0x66,0x3e,
0x41,0x8b,0x0c,0x48,0x3e,0x44,0x8b,0x40,0x1c,0x49,0x01,0xd0,
0x3e,0x41,0x8b,0x04,0x88,0x48,0x01,0xd0,0x41,0x58,0x41,0x58,
0x5e,0x59,0x5a,0x41,0x58,0x41,0x59,0x41,0x5a,0x48,0x83,0xec,
0x20,0x41,0x52,0xff,0xe0,0x58,0x41,0x59,0x5a,0x3e,0x48,0x8b,
0x12,0xe9,0x49,0xff,0xff,0xff,0x5d,0x3e,0x48,0x8d,0x8d,0x1a,
0x01,0x00,0x00,0x41,0xba,0x4c,0x77,0x26,0x07,0xff,0xd5,0x49,
0xc7,0xc1,0x00,0x00,0x00,0x00,0x3e,0x48,0x8d,0x95,0x0e,0x01,
0x00,0x00,0x3e,0x4c,0x8d,0x85,0x14,0x01,0x00,0x00,0x48,0x31,
0xc9,0x41,0xba,0x45,0x83,0x56,0x07,0xff,0xd5,0x48,0x31,0xc9,
0x41,0xba,0xf0,0xb5,0xa2,0x56,0xff,0xd5,0x68,0x65,0x6c,0x6c,
0x6f,0x00,0x68,0x65,0x6c,0x6c,0x6f,0x00,0x75,0x73,0x65,0x72,
0x33,0x32,0x2e,0x64,0x6c,0x6c,0x00]

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

proc enumSegmentCallback(psegment: ptr segmentt, arg: pointer): boolt {.cdecl.} =
  segmentList.add(psegment[])
  result = boolt.True


proc printSegmentInfo(prefix: string, s: segmentt) =
  echo prefix, "Segment Base: ", s.base,
      "\n", prefix, "Segment End: ", s.endfield,
      "\n", prefix, "Segment Size: ", s.size,
      "\n", prefix, "Segment Prot: ", s.prot


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

proc printMemoryReadResult(prefix: string, buffer: openArray[bytet]) =
  echo prefix & buffer.map(it => fmt"{it:02X}").join(" ")

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

proc testisProcessAlive() =
  var p: processt
  let status = Getprocess(p.addr)
  assert cast[bool](status), "Getprocess failed."
  let alive = Isprocessalive(p.addr)
  echo "Isprocessalive: ", alive
  assert cast[bool](alive), "Isprocessalive failed."

testisProcessAlive()

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

proc testEnumprocesses() =
  var status: boolt = Enumprocesses(enumProcessCallback, nil)
  assert cast[bool](status), "Enumprocesses failed."
  assert processList.len > 0, "Enumprocesses failed."
  for p in processList:
    printProcessInfo("Enumprocesses: ", p)

testEnumprocesses()

proc testEnumthreads() =
  var status: boolt = Enumthreads(enumThreadCallback, nil)
  assert cast[bool](status), "Enumthreads failed."
  assert threadList.len > 0, "Enumthreads failed."
  for t in threadList:
    printThreadInfo("Enumthreads: ", t)

testEnumthreads()

proc testEnumThreadsEx() =
  var p: processt = processList[0]
  var status: boolt = Enumthreadsex(p.addr, enumThreadCallback2, nil)
  assert cast[bool](status), "Enumthreadsex failed."
  assert threadList2.len > 0, "Enumthreadsex failed."
  for t in threadList2:
    printThreadInfo("Enumthreadsex: ", t)

testEnumThreadsEx()

proc testEnumModules() =
  var status: boolt = Enummodules(enumModuleCallback, nil)
  assert cast[bool](status), "Enummodules failed."
  assert moduleList.len > 0, "Enummodules failed."
  for m in moduleList:
    printModuleInfo("Enummodules: ", m)

testEnumModules()

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


proc testEnumSymbols() =
  var p: processt = processList[0]
  var m: modulet
  let status = Findmodule("ntdll.dll", m.addr)
  var status2: boolt = Enumsymbols(m.addr, enumSymbolCallback, nil)
  assert cast[bool](status2), "Enumsymbols failed."
  assert symbolList.len > 0, "Enumsymbols failed."
  for s in symbolList:
    printSymbolInfo("Enumsymbols: ", s)

testEnumSymbols()

proc testFindSymbolAddress() =
  var m: modulet
  let status = Findmodule("ntdll.dll", m.addr)
  var address = Findsymboladdress(m.addr, "NtClose")
  echo "Findsymboladdress: ", address
  assert address != 0, "Findsymboladdress failed."

testFindSymbolAddress()


proc testEnumSegments() =
  var status: boolt = Enumsegments(enumSegmentCallback, nil)
  assert cast[bool](status), "Enumsegments failed."
  assert segmentList.len > 0, "Enumsegments failed."
  for s in segmentList:
    printSegmentInfo("Enumsegments: ", s)

testEnumSegments()

proc testEnumSegmentsEx() =
  var p: processt = processList[0]
  var status: boolt = Enumsegmentsex(p.addr, enumSegmentCallback, nil)
  assert cast[bool](status), "Enumsegmentsex failed."
  assert segmentList.len > 0, "Enumsegmentsex failed."
  for s in segmentList:
    printSegmentInfo("Enumsegmentsex: ", s)

testEnumSegmentsEx()


proc testFindSegment() =
  var s: segmentt
  var p: processt = processList[0]
  var m: modulet = moduleList[0]
  var moduleaddress = m.base
  let status = Findsegment(moduleaddress, s.addr)
  assert cast[bool](status), "Findsegment failed."
  printSegmentInfo("Findsegment: ", s)

testFindSegment()

proc testFindSegmentEx() =
  var s: segmentt
  var p: processt
  var m: modulet
  let procstatus = Getprocessex(cast[pidt](23892), p.addr)
  assert cast[bool](procstatus), "Getprocessex failed."
  let modstatus = Findmoduleex(p.addr, "ntdll.dll", m.addr)
  assert cast[bool](modstatus), "Findmoduleex failed."
  let status = Findsegmentex(p.addr, m.base, s.addr)
  assert cast[bool](status), "Findsegmentex failed."
  printSegmentInfo("Findsegmentex: ", s)

testFindSegmentEx()

proc testReadMemory() =
  var
    p: processt
    m: modulet
  let
    procstatus = Getprocess(p.addr)
    modstatus = Findmodule("ntdll.dll", m.addr)
  var
    sourceAddress: addresst = m.base
    sizeToRead: sizet = 1024
    bbuffer: array[1024, bytet]
  assert cast[bool](procstatus), "Getprocess failed."
  assert cast[bool](modstatus), "Findmodule failed."

  let status = Readmemory(sourceAddress, addr bbuffer[0], sizeToRead)
  assert status == sizeToRead, "Readmemory failed."
  printMemoryReadResult("Readmemory: ", bbuffer)


testReadMemory()

proc testReadMemoryEx() =
  var
    p: processt
    m: modulet
  let
    procstatus = Getprocessex(cast[pidt](23892), p.addr)
    modstatus = Findmoduleex(p.addr, "ntdll.dll", m.addr)
  var
    sourceAddress: addresst = m.base
    sizeToRead: sizet = 1024
    bbuffer: array[1024, bytet]
  assert cast[bool](procstatus), "Getprocess failed."
  assert cast[bool](modstatus), "Findmodule failed."

  let status = Readmemoryex(p.addr, sourceAddress, addr bbuffer[0], sizeToRead)
  assert status == sizeToRead, "Readmemoryex failed."
  printMemoryReadResult("Readmemoryex: ", bbuffer)

testReadMemoryEx()


proc testSetMemory() =
  var
    p: processt
    m: modulet
  let
    procstatus = Getprocess(p.addr)
    modstatus = Findmodule("ntdll.dll", m.addr)
    destAddress: addresst = m.base
    sizeToChangeProtFor: sizet = 1024

  let prot = Protmemory(destAddress, cast[sizet](sizeToChangeProtFor), cast[prott](Protxrw), nil)
  let status = Setmemory(destAddress, cast[bytet](0x90), cast[sizet](sizeToChangeProtFor))
  assert cast[bool](status), "Setmemory failed."
  echo $prot
  echo $status
  echo "SetMemoryPassed"

testSetMemory()

proc testSetMemoryEx() =
  var
    p: processt
    m: modulet
  let
    procstatus = Getprocessex(cast[pidt](23892), p.addr)
    modstatus = Findmoduleex(p.addr, "ntdll.dll", m.addr)
    destAddress: addresst = m.base
    sizeToChangeProtFor: sizet = 1024

  let prot = Protmemoryex(p.addr, destAddress, cast[sizet](sizeToChangeProtFor), cast[prott](Protxrw), nil)
  let status = Setmemoryex(p.addr, destAddress, cast[bytet](0x90), cast[sizet](sizeToChangeProtFor))
  assert cast[bool](status), "Setmemoryex failed."
  echo $prot
  echo $status
  echo "SetMemoryExPassed"

testSetMemoryEx()


proc testProtMemory() =
  var
    p: processt
    m: modulet
    oldprot: prott
  let
    procstatus = Getprocess(p.addr)
    modstatus = Findmodule("ntdll.dll", m.addr)
    destAddress: addresst = m.base
    sizeToChangeProtFor: sizet = 1024

  let status = Protmemory(destAddress, cast[sizet](sizeToChangeProtFor), cast[prott](Protxrw), addr oldprot)
  debugEcho "Old Protection: ", $oldprot
  assert cast[bool](status), "Protmemory failed."

testProtMemory()

proc testProtMemoryEx() =
  var
    p: processt
    m: modulet
    oldprot: prott
  let
    procstatus = Getprocessex(cast[pidt](23892), p.addr)
    modstatus = Findmoduleex(p.addr, "ntdll.dll", m.addr)
    destAddress: addresst = m.base
    sizeToChangeProtFor: sizet = 1024
  let status = Protmemoryex(p.addr, destAddress, cast[sizet](sizeToChangeProtFor), cast[prott](Protxrw), addr oldprot)
  debugEcho "Old Protection: ", $oldprot
  assert cast[bool](status), "Protmemoryex failed."

testProtMemoryEx()

proc testWriteMemory() =
  var
    p: processt
    m: modulet
    procstatus = Getprocess(p.addr)
    modstatus = Findmodule("ntdll.dll", m.addr)
    destAddress: addresst = m.base
    sizeToWrite = sizeof(buf).int
    src = addr buf[0]

  assert cast[bool](procstatus), "Getprocess failed."
  assert cast[bool](modstatus), "Findmodule failed."
  let prot = Protmemoryex(p.addr, destAddress, cast[sizet](sizeToWrite), cast[prott](Protxrw), nil)
  let written = WritememoryEx(p.addr,destAddress, src, cast[sizet](sizeToWrite))
  assert written == cast[sizet](sizeToWrite), "Writememory failed."
  echo $prot
  echo $written

testWriteMemory()

proc testWriteMemoryEx() =
  var
    p: processt
    m: modulet
    procstatus = Getprocessex(cast[pidt](23892), p.addr)
    modstatus = Findmoduleex(p.addr, "ntdll.dll", m.addr)
    destAddress: addresst = m.base
    sizeToWrite = sizeof(buf).int
    src = addr buf[0]

  assert cast[bool](procstatus), "Getprocess failed."
  assert cast[bool](modstatus), "Findmodule failed."
  let prot = Protmemoryex(p.addr, destAddress, cast[sizet](sizeToWrite), cast[prott](Protxrw), nil)
  let written = Writememoryex(p.addr, destAddress, src, cast[sizet](sizeToWrite))
  assert written == cast[sizet](sizeToWrite), "Writememoryex failed."
  echo $prot
  echo $written

testWriteMemoryEx()

proc testAllocMemory() =
  var
    p: processt
    m: modulet
    procstatus = Getprocess(p.addr)
    modstatus = Findmodule("ntdll.dll", m.addr)
    sizeToAlloc = 1024
    prot: prott = cast[prott](Protxrw)
    oldprot: prott
    alloc: addresst
  assert cast[bool](procstatus), "Getprocess failed."
  assert cast[bool](modstatus), "Findmodule failed."
  let status = Allocmemory(cast[sizet](sizeToAlloc), prot)
  assert status != 0, "Allocmemory failed."
  let protstatus = Protmemory(status, cast[sizet](sizeToAlloc), prot, addr oldprot)
  assert cast[bool](protstatus), "Protmemory failed."
  echo "Allocated at Addr: ", toHex(status)
  debugEcho protstatus
  echo "Old Protection: ", $oldprot

testAllocMemory()

proc testAllocMemoryEx() =
  var
    p: processt
    m: modulet
    procstatus = Getprocessex(cast[pidt](23892), p.addr)
    modstatus = Findmoduleex(p.addr, "ntdll.dll", m.addr)
    sizeToAlloc = 1024
    prot: prott = cast[prott](Protxrw)
    oldprot: prott
    alloc: addresst
  assert cast[bool](procstatus), "Getprocess failed."
  assert cast[bool](modstatus), "Findmodule failed."
  let status = Allocmemoryex(p.addr, cast[sizet](sizeToAlloc), prot)
  assert status != 0, "Allocmemory failed."
  let protstatus = Protmemoryex(p.addr, status, cast[sizet](sizeToAlloc), prot, addr oldprot)
  assert cast[bool](protstatus), "Protmemory failed."
  echo "AllocatedEx at Addr: ", toHex(status)
  debugEcho protstatus
  echo "Old Protection: ", $oldprot

testAllocMemoryEx()

proc testFreeMemory() =
  var
    p: processt
    m: modulet
    procstatus = Getprocess(p.addr)
    modstatus = Findmodule("ntdll.dll", m.addr)
    sizeToAlloc = 1024
    prot: prott = cast[prott](Protxrw)
    oldprot: prott
    alloc: addresst
  assert cast[bool](procstatus), "Getprocess failed."
  assert cast[bool](modstatus), "Findmodule failed."
  let status = Allocmemory(cast[sizet](sizeToAlloc), prot)
  assert status != 0, "Allocmemory failed."
  let protstatus = Protmemory(status, cast[sizet](sizeToAlloc), prot, addr oldprot)
  assert cast[bool](protstatus), "Protmemory failed."
  echo "Allocated at Addr: ", toHex(status)
  debugEcho protstatus
  echo "Old Protection: ", $oldprot
  let status2 = Freememory(status, cast[sizet](sizeToAlloc))
  assert cast[bool](status2), "Freememory failed."
  echo "Freed Memory at Addr: ", toHex(status)

testFreeMemory()

proc testFreeMemoryEx() =
  var
    p: processt
    m: modulet
    procstatus = Getprocessex(cast[pidt](23892), p.addr)
    modstatus = Findmoduleex(p.addr, "ntdll.dll", m.addr)
    sizeToAlloc = 1024
    prot: prott = cast[prott](Protxrw)
    oldprot: prott
    alloc: addresst
  assert cast[bool](procstatus), "Getprocess failed."
  assert cast[bool](modstatus), "Findmodule failed."
  let status = Allocmemoryex(p.addr, cast[sizet](sizeToAlloc), prot)
  assert status != 0, "Allocmemory failed."
  let protstatus = Protmemoryex(p.addr, status, cast[sizet](sizeToAlloc), prot, addr oldprot)
  assert cast[bool](protstatus), "Protmemory failed."
  echo "Allocated at Addr: ", toHex(status)
  debugEcho protstatus
  echo "Old Protection: ", $oldprot
  let status2 = Freememoryex(p.addr, status, cast[sizet](sizeToAlloc))
  assert cast[bool](status2), "Freememory failed."
  echo "Freed MemoryEx at Addr: ", toHex(status)

testFreeMemoryEx()

proc testDeepPointer() =
  var
    p: processt
    m: modulet
    procstatus = Getprocess(p.addr)
    modstatus = Findmodule("test_nimlibmem_DB20BAD8F78E919B343F8656719D9E1A97A797CC.exe", m.addr)
  printModuleInfo("Findmodule: ", m)
  printProcessInfo("Getprocess: ", p)
  var naddr = m.base + 0x00087C58
  var offsets = array[0..1, addresst]([cast[addresst](0x0), cast[addresst](0x28)])
  let deepPointer = Deeppointer(naddr, offsets[0].addr, cast[csize_t](offsets.len))
  echo "Deep Pointer: ", toHex(deepPointer)
testDeepPointer()

proc testDeepPointerEx() =
  var
    p: processt
    m: modulet
    procstatus = Getprocessex(cast[pidt](23892), p.addr)
    modstatus = Findmoduleex(p.addr, "notepad.exe", m.addr)
  printModuleInfo("Findmoduleex: ", m)
  printProcessInfo("Getprocessex: ", p)
  var offsets = array[0..4, addresst]([cast[addresst](0x0), cast[addresst](0xB0), cast[addresst](0x70), cast[addresst](0x0), cast[addresst](0xF8)])
  echo "Offsets: ", offsets
  let deepPointer = Deeppointerex(p.addr, m.base+ 0x00030300, offsets[0].addr, cast[sizet](offsets.len))
  echo "Deep Pointer: ", deepPointer
testDeepPointerEx()

## Not implemented yet
# proc testLoadModule() =
#   const test_module = "ntdll.dll"
#   var m: modulet
#   let status = Loadmodule(test_module, m.addr)
#   assert cast[bool](status), "Loadmodule failed."
#   printModuleInfo("Loadmodule: ", m)
#
# testLoadModule()

## Not implemented yet
# proc testLoadModuleEx() =
#   const test_module = "C:\\Windows\\System32\\ntdll.dll"
#   var testpid: pidt = 23892
#   var p: processt
#   var m: modulet
#   var processstatus = Getprocessex(testpid, p.addr)
#   printProcessInfo("Getprocessex: ", p)
#   assert cast[bool](processstatus), "Getprocessex failed."
#   let status = Loadmoduleex(p.addr, test_module, m.addr)
#   assert cast[bool](status), "Loadmoduleex failed."
#   printModuleInfo("Loadmoduleex: ", m)
#
# testLoadModuleEx()

## No clue how to use this and what the actual use case is
# proc Demanglesymbol*(symbolname: stringt; demangledbuf: cstring; maxsize: sizet): cstring {.libmem, importc: "LM_DemangleSymbol".}
## No clue how to use this and what the actual use case is
# proc Freedemangledsymbol*(symbolname: cstring): void {.libmem, importc: "LM_FreeDemangledSymbol".}
## No clue how to use this and what the actual use case is
# proc Enumsymbolsdemangled*(module: ptr modulet; callback: proc (a0: ptr symbolt;a1: pointer): boolt {.cdecl.}; arg: pointer): boolt {.libmem, importc: "LM_EnumSymbolsDemangled".}
## No clue how to use this and what the actual use case is
# proc Findsymboladdressdemangled*(module: ptr modulet; symbolname: stringt): addresst {.libmem, importc: "LM_FindSymbolAddressDemangled".}
## No clue how to use this and what the actual use case is
# proc Enumsegments*(callback: proc (a0: ptr segmentt; a1: pointer): boolt {.cdecl.};arg: pointer): boolt {.libmem, importc: "LM_EnumSegments".}



## add readLine for pause
proc readLine() =
  var line = stdin.readLine()
  if line == "q":
    quit(0)

readLine()