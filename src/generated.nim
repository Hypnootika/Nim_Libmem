
const
  Protnone* = cint(0)
const
  Protx* = cint(1)
const
  Protr* = cint(2)
const
  Protw* = cint(4)
const
  Protxr* = cint(3)
const
  Protxw* = cint(5)
const
  Protrw* = cint(6)
const
  Protxrw* = cint(7)
type
  Apiimport* = distinct object
type
  boolt* = int32             ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:77:18
  bytet* = uint8             ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:78:18
  addresst* = uint64         ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:79:18
  sizet* = uint64            ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:80:18
  chart* = cschar            ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:83:26
  stringt* = cstring         ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:84:26
  pidt* = uint32             ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:87:18
  tidt* = uint32             ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:88:18
  timet* = uint64            ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:89:18
  prott* = uint32            ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:112:18
  structprocesst* {.pure, inheritable, bycopy.} = object
    pid*: pidt               ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:114:9
    ppid*: pidt
    bits*: sizet
    starttime*: timet
    path*: array[4096'i64, chart]
    name*: array[4096'i64, chart]

  processt* = structprocesst ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:121:3
  structthreadt* {.pure, inheritable, bycopy.} = object
    tid*: tidt               ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:123:9
    ownerpid*: pidt

  threadt* = structthreadt   ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:126:3
  structmodulet* {.pure, inheritable, bycopy.} = object
    base*: addresst          ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:128:9
    endfield*: addresst
    size*: sizet
    path*: array[4096'i64, chart]
    name*: array[4096'i64, chart]

  modulet* = structmodulet   ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:134:3
  structpaget* {.pure, inheritable, bycopy.} = object
    base*: addresst          ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:136:9
    endfield*: addresst
    size*: sizet
    prot*: prott

  paget* = structpaget       ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:141:3
  structsymbolt* {.pure, inheritable, bycopy.} = object
    name*: stringt           ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:143:9
    address*: addresst

  symbolt* = structsymbolt   ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:146:3
  structinstt* {.pure, inheritable, bycopy.} = object
    address*: addresst       ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:149:9
    size*: sizet
    bytes*: array[16'i64, bytet]
    mnemonic*: array[32'i64, chart]
    opstr*: array[160'i64, chart]

  instt* = structinstt       ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:155:3
  structvmtentryt* {.pure, inheritable, bycopy.} = object
    origfunc*: addresst      ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:158:16
    index*: sizet
    next*: ptr structvmtentryt

  vmtentryt* = structvmtentryt ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:162:3
  structvmtt* {.pure, inheritable, bycopy.} = object
    origprot*: prott         ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:164:9
    vtable*: ptr addresst
    entries*: ptr vmtentryt

  vmtt* = structvmtt         ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:168:3
when 0 is static:
  const
    False* = 0               ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:53:9
else:
  let False* = 0             ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:53:9
when 1 is static:
  const
    True* = 1                ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:54:9
else:
  let True* = 1              ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:54:9
when 0 is static:
  const
    Null* = 0                ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:55:9
else:
  let Null* = 0              ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:55:9
when 4096 is static:
  const
    Pathmax* = 4096          ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:62:9
else:
  let Pathmax* = 4096        ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:62:9
when 16 is static:
  const
    Instmax* = 16            ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:63:9
else:
  let Instmax* = 16          ## Generated based on D:\libmemv5\bindings\Nim\src\Libmem\libmem.h:63:9
proc Enumprocesses*(callback: proc (a0: ptr processt; a1: pointer): boolt {.
    cdecl.}; arg: pointer): boolt {.cdecl, importc: "LM_EnumProcesses".}
proc Getprocess*(processout: ptr processt): boolt {.cdecl,
    exportc: "LM_GetProcess", customPragma("Hello world"), used.}
proc Getprocessex*(pid: pidt; processout: ptr processt): boolt {.cdecl,
    importc: "LM_GetProcessEx".}
proc Findprocess*(processname: stringt; processout: ptr processt): boolt {.
    cdecl, importc: "LM_FindProcess".}
proc Isprocessalive*(process: ptr processt): boolt {.cdecl,
    importc: "LM_IsProcessAlive".}
proc Getsystembits*(): sizet {.cdecl, importc: "LM_GetSystemBits".}
proc Enumthreads*(callback: proc (a0: ptr threadt; a1: pointer): boolt {.cdecl.};
                  arg: pointer): boolt {.cdecl, importc: "LM_EnumThreads".}
proc Enumthreadsex*(process: ptr processt; callback: proc (a0: ptr threadt;
    a1: pointer): boolt {.cdecl.}; arg: pointer): boolt {.cdecl,
    importc: "LM_EnumThreadsEx".}
proc Getthread*(threadout: ptr threadt): boolt {.cdecl, importc: "LM_GetThread".}
proc Getthreadex*(process: ptr processt; threadout: ptr threadt): boolt {.cdecl,
    importc: "LM_GetThreadEx".}
proc Getthreadprocess*(thread: ptr threadt; processout: ptr processt): boolt {.
    cdecl, importc: "LM_GetThreadProcess".}
proc Enummodules*(callback: proc (a0: ptr modulet; a1: pointer): boolt {.cdecl.};
                  arg: pointer): boolt {.cdecl, importc: "LM_EnumModules".}
proc Enummodulesex*(process: ptr processt; callback: proc (a0: ptr modulet;
    a1: pointer): boolt {.cdecl.}; arg: pointer): boolt {.cdecl,
    importc: "LM_EnumModulesEx".}
proc Findmodule*(name: stringt; moduleout: ptr modulet): boolt {.cdecl,
    importc: "LM_FindModule".}
proc Findmoduleex*(process: ptr processt; name: stringt; moduleout: ptr modulet): boolt {.
    cdecl, importc: "LM_FindModuleEx".}
proc Loadmodule*(path: stringt; moduleout: ptr modulet): boolt {.cdecl,
    importc: "LM_LoadModule".}
proc Loadmoduleex*(process: ptr processt; path: stringt; moduleout: ptr modulet): boolt {.
    cdecl, importc: "LM_LoadModuleEx".}
proc Unloadmodule*(module: ptr modulet): boolt {.cdecl,
    importc: "LM_UnloadModule".}
proc Unloadmoduleex*(process: ptr processt; module: ptr modulet): boolt {.cdecl,
    importc: "LM_UnloadModuleEx".}