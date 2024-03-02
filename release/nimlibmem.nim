import memlib
const libpath = "..\\release\\libmem.dll"
const dll = staticReadDll(libpath)
let lib = checkedLoadLib(dll)
buildPragma {cdecl, memlib: lib}: libmem

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
  enumboolt* {.size: sizeof(cint).} = enum
    False = 0, True = 1
type
  Apiimport* = distinct object
type
  boolt* = enumboolt         
  bytet* = uint8             
  addresst* = uint64         
  sizet* = uint64            
  chart* = cchar            
  stringt* = cstring         
  pidt* = uint32             
  tidt* = uint32             
  timet* = uint64            
  prott* = uint32            
  structprocesst* {.pure, inheritable, bycopy.} = object
    pid*: pidt               
    ppid*: pidt
    bits*: sizet
    starttime*: timet
    path*: array[4096'i64, chart]
    name*: array[4096'i64, chart]

  processt* = structprocesst 
  structthreadt* {.pure, inheritable, bycopy.} = object
    tid*: tidt               
    ownerpid*: pidt

  threadt* = structthreadt   
  structmodulet* {.pure, inheritable, bycopy.} = object
    base*: addresst          
    endfield*: addresst
    size*: sizet
    path*: array[4096'i64, chart]
    name*: array[4096'i64, chart]

  modulet* = structmodulet   
  structpaget* {.pure, inheritable, bycopy.} = object
    base*: addresst          
    endfield*: addresst
    size*: sizet
    prot*: prott

  paget* = structpaget       
  structsymbolt* {.pure, inheritable, bycopy.} = object
    name*: stringt           
    address*: addresst

  symbolt* = structsymbolt   
  structinstt* {.pure, inheritable, bycopy.} = object
    address*: addresst       
    size*: sizet
    bytes*: array[16'i64, bytet]
    mnemonic*: array[32'i64, chart]
    opstr*: array[160'i64, chart]

  instt* = structinstt       
  structvmtentryt* {.pure, inheritable, bycopy.} = object
    origfunc*: addresst      
    index*: sizet
    next*: ptr structvmtentryt

  vmtentryt* = structvmtentryt 
  structvmtt* {.pure, inheritable, bycopy.} = object
    origprot*: prott         
    vtable*: ptr addresst
    entries*: ptr vmtentryt

  vmtt* = structvmtt         
when 0 is static:
  const
    Null* = 0                
else:
  let Null* = 0              
when 4096 is static:
  const
    Pathmax* = 4096          
else:
  let Pathmax* = 4096        
when 16 is static:
  const
    Instmax* = 16            
else:
  let Instmax* = 16          
proc Enumprocesses*(callback: proc (a0: ptr processt; a1: pointer): boolt {.cdecl.}; arg: pointer): boolt {.libmem, importc: "LM_EnumProcesses".}
proc Getprocess*(processout: ptr processt): boolt {.libmem, importc: "LM_GetProcess".}
proc Getprocessex*(pid: pidt; processout: ptr processt): boolt {.libmem, importc: "LM_GetProcessEx".}
proc Findprocess*(processname: stringt; processout: ptr processt): boolt {.libmem, importc: "LM_FindProcess".}
proc Isprocessalive*(process: ptr processt): boolt {.libmem, importc: "LM_IsProcessAlive".}
proc Getsystembits*(): sizet {.libmem, importc: "LM_GetSystemBits".}
proc Enumthreads*(callback: proc (a0: ptr threadt; a1: pointer): boolt {.cdecl.};arg: pointer): boolt {.libmem, importc: "LM_EnumThreads".}
proc Enumthreadsex*(process: ptr processt; callback: proc (a0: ptr threadt;a1: pointer): boolt {.cdecl.}; arg: pointer): boolt {.libmem, importc: "LM_EnumThreadsEx".}
proc Getthread*(threadout: ptr threadt): boolt {.libmem, importc: "LM_GetThread".}
proc Getthreadex*(process: ptr processt; threadout: ptr threadt): boolt {.libmem, importc: "LM_GetThreadEx".}
proc Getthreadprocess*(thread: ptr threadt; processout: ptr processt): boolt {.libmem, importc: "LM_GetThreadProcess".}
proc Enummodules*(callback: proc (a0: ptr modulet; a1: pointer): boolt {.cdecl.};arg: pointer): boolt {.libmem, importc: "LM_EnumModules".}
proc Enummodulesex*(process: ptr processt; callback: proc (a0: ptr modulet;a1: pointer): boolt {.cdecl.}; arg: pointer): boolt {.libmem, importc: "LM_EnumModulesEx".}
proc Findmodule*(name: stringt; moduleout: ptr modulet): boolt {.libmem, importc: "LM_FindModule".}
proc Findmoduleex*(process: ptr processt; name: stringt; moduleout: ptr modulet): boolt {.libmem, importc: "LM_FindModuleEx".}
proc Loadmodule*(path: stringt; moduleout: ptr modulet): boolt {.libmem, importc: "LM_LoadModule".}
proc Loadmoduleex*(process: ptr processt; path: stringt; moduleout: ptr modulet): boolt {.libmem, importc: "LM_LoadModuleEx".}
proc Unloadmodule*(module: ptr modulet): boolt {.libmem, importc: "LM_UnloadModule".}
proc Unloadmoduleex*(process: ptr processt; module: ptr modulet): boolt {.libmem, importc: "LM_UnloadModuleEx".}
proc Enumsymbols*(module: ptr modulet; callback: proc (a0: ptr symbolt;a1: pointer): boolt {.cdecl.}; arg: pointer): boolt {.libmem, importc: "LM_EnumSymbols".}
proc Findsymboladdress*(module: ptr modulet; name: stringt): addresst {.libmem, importc: "LM_FindSymbolAddress".}
proc Demanglesymbol*(symbolname: stringt; demangledbuf: cstring; maxsize: sizet): stringt {.libmem, importc: "LM_DemangleSymbol".}
proc Freedemanglesymbol*(symbolname: cstring): void {.libmem, importc: "LM_FreeDemangleSymbol".}
proc Enumsymbolsdemangled*(module: ptr modulet; callback: proc (a0: ptr symbolt;a1: pointer): boolt {.cdecl.}; arg: pointer): boolt {.libmem, importc: "LM_EnumSymbolsDemangled".}
proc Findsymboladdressdemangled*(module: ptr modulet; name: stringt): addresst {.libmem, importc: "LM_FindSymbolAddressDemangled".}