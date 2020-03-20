import 'package:libclang/libclang.dart';
import 'package:meta/meta.dart';

import 'declarations.dart';

class UnsupportedFeatureException implements Exception {
  final String symbolName;
  final String message;

  const UnsupportedFeatureException({
    @required this.symbolName,
    this.message,
  });
}

abstract class Mapper {
  void map(String libraryName, Cursor cursor, StringSink output);
}

bool _checkIsFunctionType(ClangType type) {
  switch (type.kind) {
    case CXTypeKind.CXType_Unexposed:
      return type.resultType.use((v) => v.kind != CXTypeKind.CXType_Invalid);
    case CXTypeKind.CXType_FunctionProto:
      return true;
    default:
      return false;
  }
}

MappedType _mapFunctionType(ClangType type) {
  if (type.isFunctionVariadic) return null;

  return useBag((bag) {
    final resultType = type.resultType.withBag(bag);
    assert(resultType.kind != CXTypeKind.CXType_Invalid);

    final mappedResultType = _mapType(resultType);
    if (mappedResultType == null) return null;

    final arguments =
        type.argumentTypes.map((arg) => _mapType(arg.withBag(bag)));
    if (arguments.any((arg) => arg == null)) return null;

    return MappedType(
      dartType:
          '${mappedResultType.dartType} Function(${arguments.map((arg) => arg.dartType).join(', ')})',
      ffiType:
          '${mappedResultType.ffiType} Function(${arguments.map((arg) => arg.ffiType).join(', ')})',
    );
  });
}

MappedType _mapType(ClangType type) {
  switch (type.kind) {
    case CXTypeKind.CXType_Invalid:
      return null;
    case CXTypeKind.CXType_Unexposed:
      return useBag((bag) {
        if (_checkIsFunctionType(type)) {
          // It's a function type.
          return _mapFunctionType(type);
        }

        final canonicalType = type.canonicalType.withBag(bag);
        if (canonicalType.kind != CXTypeKind.CXType_Unexposed) {
          // There is a canonical type available - use that.
          return _mapType(canonicalType);
        }

        return null;
      });
    case CXTypeKind.CXType_Void:
      return MappedType(dartType: 'void', ffiType: 'Void');
    case CXTypeKind.CXType_Char_U:
    case CXTypeKind.CXType_UChar:
    case CXTypeKind.CXType_UShort:
    case CXTypeKind.CXType_UInt:
    case CXTypeKind.CXType_ULong:
    case CXTypeKind.CXType_ULongLong:
      return MappedType(dartType: 'int', ffiType: 'Uint${type.size * 8}');
    case CXTypeKind.CXType_Char_S:
    case CXTypeKind.CXType_SChar:
    case CXTypeKind.CXType_Short:
    case CXTypeKind.CXType_Int:
    case CXTypeKind.CXType_Long:
    case CXTypeKind.CXType_LongLong:
      return MappedType(dartType: 'int', ffiType: 'Int${type.size * 8}');
    case CXTypeKind.CXType_Float:
      return MappedType(dartType: 'double', ffiType: 'Float');
    case CXTypeKind.CXType_Double:
      return MappedType(dartType: 'double', ffiType: 'Double');
    case CXTypeKind.CXType_Typedef:
      return type.canonicalType.use(_mapType);
    case CXTypeKind.CXType_Elaborated:
      return type.namedType.use(_mapType);
    case CXTypeKind.CXType_Enum:
      return MappedType(dartType: 'int', ffiType: 'Int32');
    case CXTypeKind.CXType_FunctionProto:
      return _mapFunctionType(type);
    case CXTypeKind.CXType_Pointer:
      return useBag((bag) {
        final pointee = type.pointee.withBag(bag);
        final pointeeType = _mapType(pointee);
        if (pointeeType == null) {
          // Pointee type is not supported - use Pointer<Void> instead.
          return MappedType(dartType: 'Pointer<Void>', ffiType: 'Pointer<Void>');
        }

        final pointerType = _checkIsFunctionType(pointee)
            ? 'Pointer<NativeFunction<${pointeeType.ffiType}>>'
            : 'Pointer<${pointeeType.ffiType}>';
        return MappedType(dartType: pointerType, ffiType: pointerType);
      });
    default:
      return null;
  }
}

class FunctionMapper implements Mapper {
  const FunctionMapper();

  @override
  void map(String libraryName, Cursor cursor, StringSink output) {
    useBag((bag) {
      final type = cursor.type.withBag(bag);
      final name = cursor.spelling.withBag(bag).toString();

      if (type.isFunctionVariadic) {
        throw UnsupportedFeatureException(
          symbolName: name,
          message: 'Variadic functions are not supported.',
        );
      }

      final arguments =
          cursor.arguments.map((arg) => arg.withBag(bag)).toList();
      final resultType = type.resultType.withBag(bag);
      final mappedResultType = _mapType(resultType);
      final mappedArguments =
          arguments.map((arg) => _mapType(arg.type.withBag(bag))).toList();
      final argumentNames =
          arguments.map((arg) => arg.spelling.withBag(bag).toString()).toList();

      if (mappedResultType == null ||
          mappedArguments.any((arg) => arg == null)) {
        throw UnsupportedFeatureException(
            symbolName: name,
            message:
                'One of function parameters or its return type is not supported.');
      }

      output
        ..write(
            'typedef _${name}NativeType = ${mappedResultType.ffiType} Function(')
        ..write(mappedArguments.map((arg) => arg.ffiType).join(', '))
        ..writeln(');')
        ..write('typedef _${name}Type = ${mappedResultType.dartType} Function(')
        ..write(mappedArguments.map((arg) => arg.dartType).join(', '))
        ..writeln(');')
        ..writeln()
        ..writeln('_${name}Type _${name}Symbol;')
        ..write('${mappedResultType.dartType} ${name}(');

      if (mappedArguments.isNotEmpty) {
        output.write('${mappedArguments[0].dartType} ${argumentNames[0]}');
        for (var i = 1; i < mappedArguments.length; ++i) {
          output.write(', ${mappedArguments[i].dartType} ${argumentNames[i]}');
        }
      }

      output
        ..writeln(') {')
        ..writeln(
            '  _${name}Symbol ??= ${libraryName}.lookupFunction<_${name}NativeType, _${name}Type>(\'${name}\');')
        ..writeln('  return _${name}Symbol(${argumentNames.join(', ')});')
        ..writeln('}')
        ..writeln();
    });
  }
}

class VariableMapper implements Mapper {
  const VariableMapper();

  @override
  void map(String libraryName, Cursor cursor, StringSink output) {
    useBag((bag) {
      final type = cursor.type.withBag(bag);
      final name = cursor.spelling.withBag(bag).toString();

      final mappedType = _mapType(type);
      if (mappedType == null) {
        throw UnsupportedFeatureException(
          symbolName: name,
          message: 'Variable has unsupported type',
        );
      }

      output
        ..writeln('Pointer<${mappedType.ffiType}> _${name}Symbol;')
        ..writeln('${mappedType.dartType} get $name {')
        ..writeln(
            '  _${name}Symbol ??= $libraryName.lookup<${mappedType.ffiType}>(\'$name\');')
        ..writeln('  return _${name}Symbol.value;')
        ..writeln('}')
        ..writeln();

      if (!type.canonicalType.withBag(bag).isConstQualified) {
        output
          ..writeln('set $name(${mappedType.dartType} value) {')
          ..writeln(
              '  _${name}Symbol ??= $libraryName.lookup<${mappedType.ffiType}>(\'$name\');')
          ..writeln('  _${name}Symbol.value = value;')
          ..writeln('}')
          ..writeln();
      }
    });
  }
}

class EnumMapper implements Mapper {
  const EnumMapper();

  @override
  void map(String libraryName, Cursor cursor, StringSink output) {
    useBag((bag) {
      final name = cursor.spelling.withBag(bag).toString();
      final isAnonymous = name.isEmpty;

      if (!isAnonymous) {
        output.writeln('class $name {');
      }

      final prefix = !isAnonymous ? '  static ' : '';
      cursor.visitChildren((cursor, parent, data) {
        return useBag((bag) {
          final elementName = cursor.spelling.withBag(bag).toString();
          output.writeln(
              '${prefix}const $elementName = ${cursor.enumConstantValue};');
          return CXChildVisitResult.CXChildVisit_Continue;
        });
      });

      if (!isAnonymous) {
        output.writeln('}');
      }

      output.writeln();
    });
  }
}

class TypedefMapper implements Mapper {
  const TypedefMapper();

  @override
  void map(String libraryName, Cursor cursor, StringSink output) {
    useBag((bag) {
      final type = cursor.type
          .withBag(bag)
          .canonicalType
          .withBag(bag)
          .pointee
          .withBag(bag);
      if (!_checkIsFunctionType(type)) {
        // Dart doesn't support typedefs for non-functional types.
        return;
      }

      final name = cursor.spelling.withBag(bag).toString();
      final mappedType = _mapFunctionType(type);
      if (mappedType == null) {
        throw UnsupportedFeatureException(
          symbolName: name,
          message: 'Typedef uses unsupported language features',
        );
      }

      output..writeln('typedef $name = ${mappedType.ffiType};')..writeln();
    });
  }
}
