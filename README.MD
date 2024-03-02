# libmem Nim Bindings

This README provides information on how to integrate and use the Nim bindings for the `libmem` C library in your Nim projects. These bindings allow Nim applications to leverage the functionality of `libmem`, a C library, with ease. The bindings were primarily generated using Futhark and subsequently refined for better integration and usage in Nim.


## Quick Start

To use the `libmem` bindings in your Nim project, follow these simple steps:

1. **Include the Nim Wrapper**: Copy the `release/nimlibmem.nim` file into your project directory. This file contains the necessary Nim wrapper code to interact with the `libmem` C library.

2. **Add the DLL**: Place the `libmem.dll` from the `release` directory into an appropriate location in your project (#Note: This is only temporary until v5 of Libmem hits. Until then you should clone the Libmem repo and build the dll yourself.). Typically, this would be alongside your binary executables or within a directory that's included in your system's PATH environment variable.

3. **Adjust the DLL Path**: Depending on your project's structure, you may need to adjust the path to `libmem.dll` within the `release/nimlibmem.nim` file to ensure the library is correctly loaded at runtime.
3.5 ** Probably not needed anymore **
## Testing

Comprehensive tests have been created and are located in the `tests` directory. These tests verify the functionality and correctness of the bindings. To run the tests, navigate to the `tests` directory and execute the test scripts using your preferred Nim testing approach.
They are also a good example of how to use the library.

## Generating Bindings (Coming Soon)

If you need to regenerate the bindings or if you want to run the tests, you may invoke: 
```nim
nimble runtests
```
to run the tests and:
```nim
nimble generate_wrapper
```
to regenerate the bindings.

## Contributions

Contributions to the `libmem` Nim bindings are welcome. Whether it's improving the wrapper, adding more tests, or enhancing documentation, your input is valuable. Please submit pull requests or open issues on the project's repository to contribute.

## License

The `libmem` Nim bindings are licensed under the MIT License. You are free to use, modify, and distribute the bindings as you see fit. For more information, please refer to the `LICENSE`.txt file in the project's repository.

## Acknowledgements

Special thanks to the developers of Futhark for providing the tooling that facilitated the generation of these bindings, and to all contributors who have refined and tested the bindings to ensure they meet the needs of Nim developers.
And also thank you, @Rdbo, for the original C library.

https://github.com/rdbo/libmem
https://github.com/PMunch/futhark