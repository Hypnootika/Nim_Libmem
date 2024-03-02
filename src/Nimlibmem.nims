switch("define", "nodeclguards")
switch("define", "futharkRebuild")
switch("define", "opirRebuild")
withDir thisDir():
  switch("passL", "-L"&thisDir() & " -l:libmem.dll")
--c