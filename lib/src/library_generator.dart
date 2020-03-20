import 'dart:ffi';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:ffi_gen/src/utils.dart';
import 'package:libclang/libclang.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';
import 'mapper.dart';

// TODO: retrieve a path to the current directory (not the working one).
const _libclangPath = '/home/vasniktel/gsoc/dart/libclang_hooks/build/libclang_hooks.so';

const _systemIncludePaths = [
  '-I/usr/lib/gcc/x86_64-linux-gnu/7/include',
  '-I/usr/local/include',
  '-I/usr/lib/gcc/x86_64-linux-gnu/7/include-fixed',
  '-I/usr/include/x86_64-linux-gnu',
  '-I/usr/include'
];

class LibraryGenerator extends GeneratorForAnnotation<Library> {
  static const mappers = <int, Mapper>{
    CXCursorKind.CXCursor_FunctionDecl: FunctionMapper(),
    CXCursorKind.CXCursor_VarDecl: VariableMapper(),
    CXCursorKind.CXCursor_EnumDecl: EnumMapper(),
    CXCursorKind.CXCursor_TypedefDecl: TypedefMapper()
  };

  static const supportedLanguages = <int>{
    CXLanguageKind.CXLanguage_C,
    CXLanguageKind.CXLanguage_Invalid, // libclang doesn't always determine the language correctly
  };

  void generateOutput(Library library, String elementName, StringSink output) {
    libclang ??= DynamicLibrary.open(_libclangPath);

    for (final header in library.headers) {
      useBag((bag) {
        final tu = TranslationUnit(
          index: Index().withBag(bag),
          cliArgs: _systemIncludePaths + library.configs,
          fileName: header,
          options: CXTranslationUnit_DetailedPreprocessingRecord
        ).withBag(bag);

        final diagnostics = tu.diagnostics
          .map((val) => val.withBag(bag))
          .where((val) => val.severity > CXDiagnosticSeverity.CXDiagnostic_Warning)
          .toList();

        if (diagnostics.isNotEmpty) {
          print("Skipping header '$header'. These errors occured:");
          diagnostics
            .map((val) => val.format(defaultDiagnosticDisplayOptions()).withBag(bag))
            .forEach(print);
          return; // exit bag scope
        }

        final cursor = tu.cursor.withBag(bag);

        if (!supportedLanguages.contains(cursor.language)) {
          print("Header '$header' has unsupported language - skipping.");
          return; // exit bag scope
        }

        output.writeln(
          '//\n'
          '// Symbols from $header\n'
          '//\n'
        );

        cursor.visitChildren((cursor, parent, data) {
          return useBag((bag) {
            if (!cursor.location.withBag(bag).isFromMainFile) {
              return CXChildVisitResult.CXChildVisit_Continue;
            }

            if (mappers.containsKey(cursor.kind)) {
              try {
                mappers[cursor.kind].map(elementName, cursor, output);
              } on UnsupportedFeatureException catch (e) {
                final message = e.message != null ? ': ${e.message}' : '.';
                print('Cannot generate code for "${e.symbolName}"$message');
              }
            }

            return CXChildVisitResult.CXChildVisit_Continue;
          });
        });
      });
    }
  }

  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! TopLevelVariableElement) {
      throw InvalidGenerationSourceError('Annotated element is not a top level variable');
    }

    final sb = StringBuffer();
    generateOutput(libraryFromConstant(annotation), element.displayName, sb);
    return sb.toString();
  }
}
