import  nimlibmem
import winim, strutils
import nimpy
pyExportModule("convenience_layer")
type
  Process* = object
    pid: uint32
    ppid: uint32
    bits: uint64
    starttime: timet
    path: string
    name: string

  Module* = object
    base: string
    endfield: string
    size: int
    path: string
    name: string

  Instruction* = object
    address: uint64
    size: int64
    bytes: string
    mnemonic: string
    opstr: string

  Thread* = object
    tid: uint32
    ownerpid: uint32

  Segment* = object
    base: string
    endfield: string
    size: int64
    prot: cint

  processcb* = proc (pproc: ptr processt, arg: pointer): boolt {.cdecl.}
  modulecb* = proc (pmodule: ptr modulet, arg: pointer): boolt {.cdecl.}
  threadcb* = proc (pthr: ptr threadt, arg: pointer): boolt {.cdecl.}
  segmentcb* = proc (psegment: ptr segmentt, arg: pointer): boolt {.cdecl.}
  instructioncb* = proc (pinst: ptr instt, arg: pointer): boolt {.cdecl.}

var
  processList*: seq[Process]
  moduleList*: seq[Module]
  threadList*: seq[Thread]
  segmentList*: seq[Segment]

func byteArrayToHexString*(cArray: openArray[byte]): string {.exportpy.} =
  result = ""
  for ch in cArray:
    result &= toHex(ch, 2)

func cArrayToString*(cArray: openArray[chart]): string  {.exportpy.}=
  result = newStringOfCap(cArray.len)
  for ch in cArray:
    if cast[char](ch) == '\0': break
    result.add(cast[char](ch))

converter toProcess*(pproc: processt): Process =
  result = Process(pid: pproc.pid, ppid: pproc.ppid, bits: pproc.bits, starttime: pproc.starttime, path: cArrayToString(pproc.path), name: cArrayToString(pproc.name))

converter toModule(pmodule: modulet): Module =
  result = Module(base: pmodule.base.toHex(), endfield: pmodule.endfield.toHex(), size: pmodule.size.int, path: cArrayToString(pmodule.path), name: cArrayToString(pmodule.name))

converter toThread(pthr: threadt): Thread =
  result = Thread(tid: pthr.tid, ownerpid: pthr.ownerpid)

converter toSegment(psegment: segmentt): Segment =
  result = Segment(base: psegment.base.toHex(), endfield: psegment.endfield.toHex(), size: psegment.size.int64, prot: cast[int32](psegment.prot))
#
# converter toInstruction(pinst: instt): Instruction =
#   result = Instruction(address: pinst.address, size: pinst.size.int64, bytes: byteArrayToHexString(pinst.bytes), mnemonic: cArrayToString(pinst.mnemonic), opstr: cArrayToString(pinst.opstr))
#
# converter toBoolt(b: boolt): bool =
#   result = b == boolt.True
#
# converter toBool(b: bool): boolt =
#   result = if b: boolt.True else: boolt.False


proc addToList*[T](item: T) =
  when T is Process:
    processList.add(item)
  elif T is Module:
    moduleList.add(item)
  elif T is Thread:
    threadList.add(item)
  elif T is Segment:
    segmentList.add(item)
  else:
    echo "Unsupported type"


proc enumProcesses(): seq[Process] {.exportpy.} =
  discard Enumprocesses(processcb(proc (pproc: ptr processt, arg: pointer): boolt {.cdecl.} =
    let process: Process = pproc[]
    addToList(process)
    result = boolt.True), nil)
  result = processList



proc enumModules(pid: uint32): seq[Module]  {.exportpy.}=
  var pproc: processt
  discard Getprocessex(pid, pproc.addr)
  let callbackm = proc (pmodule: ptr modulet, arg: pointer): boolt {.cdecl.} =
    let module: Module = pmodule[]
    addToList(module)
    result = boolt.True
  discard EnummodulesEx(pproc.addr, callbackm, nil)
  result = moduleList


proc enumThreads(pid: uint32): seq[Thread]  {.exportpy.}=
  var pproc: processt
  discard Getprocessex(pid, pproc.addr)
  let callbackt = proc (pthr: ptr threadt, arg: pointer): boolt {.cdecl.} =
    let thread: Thread = pthr[]
    addToList(thread)
    result = boolt.True
  discard EnumthreadsEx(pproc.addr, callbackt, nil)
  result = threadList


proc enumSegments(pid: uint32): seq[Segment]  {.exportpy.}=
  var pproc: processt
  discard Getprocessex(pid, pproc.addr)
  let callback = proc (psegment: ptr segmentt, arg: pointer): boolt {.cdecl.} =
    let segment: Segment = psegment[]
    addToList(segment)
    result = boolt.True
  discard EnumsegmentsEx(pproc.addr, callback, nil)
  result = segmentList


proc printList[T](list: seq[T])  =
  for item in list:
    echo item.repr


proc printProcesses() {.exportpy.}=
  processList = enumProcesses()
  printList(processList)

proc printModules(pid: uint32) {.exportpy.}=
  moduleList = enumModules(pid)
  printList(moduleList)

proc printThreads(pid: uint32) {.exportpy.} =
  threadList = enumThreads(pid)
  printList(threadList)

proc printSegments(pid: uint32) {.exportpy.}=
  segmentList = enumSegments(pid)
  printList(segmentList)

proc example() {.exportpy.} =
  printProcesses()
  echo "Modules for process 0"
  printModules(0)
  echo "Threads for process 0"
  printThreads(0)
  echo "Segments for process 0"
  printSegments(0)