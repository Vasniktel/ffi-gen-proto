import 'dart:ffi';

import 'package:ffi_gen/ffi_gen.dart';
import 'package:ffi_gen/src/library_generator.dart';

part 'main.g.dart';

@Library(headers: ['test_lib/test_lib.h'])
DynamicLibrary testlib;

void main() {
  final generator = LibraryGenerator();
  final library = Library(headers: ['test_lib/test_lib.h']);
  final sb = StringBuffer();
  generator.generateOutput(library, 'testlib', sb);
  print(sb.toString());
}
