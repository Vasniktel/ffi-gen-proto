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
