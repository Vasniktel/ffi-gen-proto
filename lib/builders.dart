library ffi_gen.builder;

import 'package:build/build.dart';
import 'package:ffi_gen/src/library_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder ffiBuilder(BuilderOptions options) =>
    SharedPartBuilder([LibraryGenerator()], 'ffi_builder');
