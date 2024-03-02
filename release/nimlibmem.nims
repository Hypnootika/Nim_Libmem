--app:console
withDir thisDir():
  switch("passL", "-L"&thisDir() & " -l:libmem.dll")
