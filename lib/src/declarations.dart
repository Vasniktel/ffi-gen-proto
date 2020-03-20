import 'package:libclang/libclang.dart';
import 'package:meta/meta.dart';

// Note: these classes haven't been used yet.

class Decl {
  final String name;
  final String file;
  const Decl({
    @required this.name,
    @required this.file,
  });
}

class VarDecl extends Decl {
  final ClangType type;
  const VarDecl({
    String name,
    String file,
    this.type,
  }) : super(name: name, file: file);
}

class FunctionDecl extends Decl {
  final ClangType returnType;
  final List<VarDecl> parameters;
  final bool isVariadic;

  const FunctionDecl({
    String name,
    String file,
    this.returnType,
    this.parameters,
    this.isVariadic = false,
  }) : super(name: name, file: file);
}

class StructDecl extends Decl {
  final List<VarDecl> fields;

  const StructDecl({
    String name,
    String file,
    this.fields,
  }) : super(name: name, file: file);
}

class EnumElem {
  final String name;
  final int value;
  const EnumElem(this.name, this.value);
}

class EnumDecl extends Decl {
  final List<EnumElem> elements;
  const EnumDecl({
    String name,
    String file,
    this.elements,
  }) : super(name: name, file: file);
}

class TypedefDecl extends Decl {
  final ClangType desugaredType;

  const TypedefDecl({
    String name,
    String file,
    this.desugaredType,
  }) : super(name: name, file: file);
}

class MappedType {
  final String dartType;
  final String ffiType;

  const MappedType({
    @required this.dartType,
    @required this.ffiType,
  });
}
