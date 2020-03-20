## ffi_gen

A simple prototype for the Dart FFI bindings generator.
This directory contains:
- bindings for libclang in `libclang/` folder
- additional wrappers for libclang in `libclang_hooks/` folder
- the library itself that uses `source_gen` in `lib/` folder
- example of how this library can be used in `example/` folder

To run:
- compile `libclang_hooks.so`; be sure to change paths to `libclang` directories in `libclang_hooks/CMakeLists.txt` so that they match your system
- change `_libclangPath` variable in `lib/src/library_generator.dart` to match your system
- you may additionally need to tune `_systemIncludePaths` in that same file
- `cd example && pub run build_runner build`

Right now, this library can generate code for functions, top-level variables, enums, typedefs. It handles all primitive types (`int`, `long`, `float`, `uint32_t`) as well as pointers to them. Note that this is not tested so there are possibly a lot of hidden corner cases, but it's good enough for a prototype I think ;).
