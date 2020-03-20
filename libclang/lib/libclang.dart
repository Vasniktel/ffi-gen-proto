import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'src/libclang_bindings.dart';
import 'src/libclang_types.dart';
import 'src/util.dart';

export 'src/libclang_bindings.dart'
    show libclang, defaultDiagnosticDisplayOptions;
export 'src/util.dart';

const CXTranslationUnit_DetailedPreprocessingRecord = 1;

class CXTypeKind {
  static const CXType_Invalid = 0;
  static const CXType_Unexposed = 1;
  static const CXType_Void = 2;
  static const CXType_Bool = 3;
  static const CXType_Char_U = 4;
  static const CXType_UChar = 5;
  static const CXType_Char16 = 6;
  static const CXType_Char32 = 7;
  static const CXType_UShort = 8;
  static const CXType_UInt = 9;
  static const CXType_ULong = 10;
  static const CXType_ULongLong = 11;
  static const CXType_UInt128 = 12;
  static const CXType_Char_S = 13;
  static const CXType_SChar = 14;
  static const CXType_WChar = 15;
  static const CXType_Short = 16;
  static const CXType_Int = 17;
  static const CXType_Long = 18;
  static const CXType_LongLong = 19;
  static const CXType_Int128 = 20;
  static const CXType_Float = 21;
  static const CXType_Double = 22;
  static const CXType_Pointer = 101;
  static const CXType_Record = 105;
  static const CXType_Enum = 106;
  static const CXType_Typedef = 107;
  static const CXType_FunctionProto = 111;
  static const CXType_Elaborated = 119;
}

class CXCursorKind {
  static const CXCursor_StructDecl = 2;
  static const CXCursor_EnumDecl = 5;
  static const CXCursor_FunctionDecl = 8;
  static const CXCursor_VarDecl = 9;
  static const CXCursor_TypedefDecl = 20;
  static const CXCursor_MacroDefinition = 501;
}

class CXLanguageKind {
  static const CXLanguage_Invalid = 0;
  static const CXLanguage_C = 1;
  static const CXLanguage_ObjC = 2;
  static const CXLanguage_CPlusPlus = 3;
}

class CXChildVisitResult {
  static const CXChildVisit_Break = 0;
  static const CXChildVisit_Continue = 1;
  static const CXChildVisit_Recurse = 2;
}

class Index implements Disposable {
  Pointer<Void> _data;

  Index({
    int excludeDeclarationsFromPCH = 0,
    int displayDiagnostics = 0,
  }) : _data = createIndex(excludeDeclarationsFromPCH, displayDiagnostics);

  @override
  void dispose() {
    disposeIndex(_data);
    _data = nullptr;
  }
}

class CXDiagnosticSeverity {
  static const CXDiagnostic_Ignored = 0;
  static const CXDiagnostic_Note = 1;
  static const CXDiagnostic_Warning = 2;
  static const CXDiagnostic_Error = 3;
  static const CXDiagnostic_Fatal = 4;
}

class Diagnostic implements Disposable {
  Pointer<Void> _data;
  Diagnostic._fromNative(this._data);

  int get severity => getDiagnosticSeverity(_data);
  ClangString format(int options) =>
      ClangString._fromNative(formatDiagnostic(_data, options));

  @override
  void dispose() {
    disposeDiagnostic(_data);
    _data = nullptr;
  }
}

class TranslationUnit implements Disposable {
  Pointer<Void> _data;

  TranslationUnit({
    Index index,
    String fileName,
    List<String> cliArgs = const [],
    int options = 0,
  }) {
    useBag((bag) {
      final cfile = Utf8.toUtf8(fileName).withBag(bag, free);
      final compileArgs = allocate<Pointer<Utf8>>(count: cliArgs.length).withBag(bag, free);
      cliArgs.asMap().forEach((i, arg) => compileArgs[i] = Utf8.toUtf8(arg).withBag(bag, free));

      _data = parseTranslationUnit(
          index._data, cfile, compileArgs, cliArgs.length, nullptr, 0, options);
    });
  }

  List<Diagnostic> get diagnostics {
    return List.generate(getNumDiagnostics(_data), (i) {
      return Diagnostic._fromNative(getDiagnostic(_data, i));
    });
  }

  @override
  void dispose() {
    disposeTranslationUnit(_data);
    _data = nullptr;
  }

  Cursor get cursor => Cursor._fromNative(getTranslationUnitCursor(_data));
}

class ClangString implements Disposable {
  Pointer<Void> _data;
  ClangString._fromNative(this._data);

  @override
  void dispose() {
    disposeString(_data);
    _data = nullptr;
  }

  @override
  String toString() => getCString(_data).ref.toString();
}

class ClangType implements Disposable {
  Pointer<Void> _data;
  ClangType._fromNative(this._data);

  @override
  void dispose() {
    disposeType(_data);
    _data = nullptr;
  }

  ClangString get spelling => ClangString._fromNative(getTypeSpelling(_data));
  bool get isFunctionVariadic => isFunctionTypeVariadic(_data) == 1;
  ClangType get resultType => ClangType._fromNative(getResultType(_data));
  int get kind => getTypeKind(_data);
  ClangType get canonicalType => ClangType._fromNative(getCanonicalType(_data));
  int get size => getSizeOf(_data);
  bool get isConstQualified => isConstQualifiedType(_data) != 0;
  ClangType get namedType => ClangType._fromNative(getNamedType(_data));
  ClangType get pointee => ClangType._fromNative(getPointeeType(_data));
  List<ClangType> get argumentTypes {
    return List.generate(getNumArgTypes(_data), (i) {
      return ClangType._fromNative(getArgType(_data, i));
    });
  }
}

class SourceLocation implements Disposable {
  Pointer<Void> _data;
  SourceLocation._fromNative(this._data);

  @override
  void dispose() {
    disposeLocation(_data);
    _data = nullptr;
  }

  bool get isFromMainFile => locationIsFromMainFile(_data) != 0;
}

typedef ChildrenVisitor = int Function(
    Cursor cursor, Cursor parent, Struct data);

const _isMacroBuiltin = isMacroBuiltin;
const _isMacroFunctionLike = isMacroFunctionLike;
const _visitChildren = visitChildren;

class _ChildrenVisitorHolder {
  static ChildrenVisitor visitor;

  static int call(
      Pointer<Void> cursor, Pointer<Void> parent, Pointer<Void> data) {
    return visitor(Cursor._fromNative(cursor), Cursor._fromNative(parent),
        data == nullptr ? null : data.cast<Struct>().ref);
  }
}

class Cursor implements Disposable {
  Pointer<Void> _data;

  Cursor._fromNative(this._data);

  @override
  void dispose() {
    disposeCursor(_data);
    _data = nullptr;
  }

  int get kind => getCursorKind(_data);

  ClangString get kindSpelling =>
      ClangString._fromNative(getCursorKindSpelling(kind));

  ClangString get spelling => ClangString._fromNative(getCursorSpelling(_data));

  ClangType get type => ClangType._fromNative(getCursorType(_data));

  SourceLocation get location =>
      SourceLocation._fromNative(getCursorLocation(_data));

  bool get isMacroBuiltin => _isMacroBuiltin(_data) != 0;

  bool get isMacroFunctionLike => _isMacroFunctionLike(_data) != 0;

  int get language => getCursorLanguage(_data);

  int get enumConstantValue => getEnumConstantValue(_data);

  List<Cursor> get arguments {
    return List.generate(getNumArguments(_data), (i) {
      return Cursor._fromNative(getArgument(_data, i));
    });
  }

  int visitChildren(ChildrenVisitor visitor, [Struct userData]) {
    final previous = _ChildrenVisitorHolder.visitor;
    _ChildrenVisitorHolder.visitor = visitor;

    final wrapperPtr = Pointer.fromFunction<CXCursorVisitorHookNative>(
        _ChildrenVisitorHolder.call, CXChildVisitResult.CXChildVisit_Break);
    final result = _visitChildren(
        _data, wrapperPtr, userData?.addressOf?.cast() ?? nullptr);

    _ChildrenVisitorHolder.visitor = previous;
    return result;
  }
}
