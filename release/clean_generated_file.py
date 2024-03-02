import re
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
gen_file = os.path.join(current_dir, "nimlibmem.nim")


def process_file():
    with open(gen_file, "r") as file:
        data = file.read()
    data = re.sub(r"##.*", "", data)
    proc_pragma_pattern = r"\{.cdecl,.*?:|\{.\n\W+cdecl,.*?:|\{.cdecl,\n.*?:"
    data = re.sub(proc_pragma_pattern, "{.libmem, importc:", data)
    whitespace_patterns = [
        (r";\n\W+", r";"),
        (r"\{.\n\W+cdecl", r"{.cdecl"),
        (r"\{.cdecl,\n\W+", r"{.cdecl,")
    ]
    for pattern, subst in whitespace_patterns:
        data = re.sub(pattern, subst, data)
    data = data.replace("cschar", "cchar")
    libname_snippet = """import memlib
const libpath = "..\\\\release\\\\libmem.dll"
const dll = staticReadDll(libpath)
let lib = checkedLoadLib(dll)
buildPragma {cdecl, memlib: lib}: libmem"""
    data = libname_snippet + "\n" + data
    with open(gen_file, "w") as file:
        file.write(data)


if __name__ == "__main__":
    os.chdir(current_dir)
    process_file()
