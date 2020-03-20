import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'libclang_types.dart';

// This variable must be initialized before any native function is called.
DynamicLibrary libclang;

clang_createIndexType _createIndexSymbol;
Pointer<Void> createIndex(
    int excludeDeclarationsFromPCH, int displayDiagnostics) {
  _createIndexSymbol ??= libclang.lookupFunction<clang_createIndexNativeType,
      clang_createIndexType>('clang_createIndex');
  return _createIndexSymbol(excludeDeclarationsFromPCH, displayDiagnostics);
}

clang_disposeIndexType _disposeIndexSymbol;
void disposeIndex(Pointer<Void> data) {
  _disposeIndexSymbol ??= libclang.lookupFunction<clang_disposeIndexNativeType,
      clang_disposeIndexType>('clang_disposeIndex');
  _disposeIndexSymbol(data);
}

clang_parseTranslationUnitType _parseTranslationUnitSymbol;
Pointer<Void> parseTranslationUnit(
    Pointer<Void> index,
    Pointer<Utf8> fileName,
    Pointer<Pointer<Utf8>> cliArgs,
    int cliArgsSize,
    Pointer<Void> unsavedFiles,
    int unsavedFilesSize,
    int options) {
  _parseTranslationUnitSymbol ??= libclang.lookupFunction<
      clang_parseTranslationUnitNativeType,
      clang_parseTranslationUnitType>('clang_parseTranslationUnit');
  return _parseTranslationUnitSymbol(index, fileName, cliArgs, cliArgsSize,
      unsavedFiles, unsavedFilesSize, options);
}

clang_disposeTranslationUnitType _disposeTranslationUnitSymbol;
void disposeTranslationUnit(Pointer<Void> data) {
  _disposeTranslationUnitSymbol ??= libclang.lookupFunction<
      clang_disposeTranslationUnitNativeType,
      clang_disposeTranslationUnitType>('clang_disposeTranslationUnit');
  _disposeTranslationUnitSymbol(data);
}

clang_hook_getTranslationUnitCursorType _getTranslationUnitCursorSymbol;
Pointer<Void> getTranslationUnitCursor(Pointer<Void> tu) {
  _getTranslationUnitCursorSymbol ??= libclang.lookupFunction<
          clang_hook_getTranslationUnitCursorNativeType,
          clang_hook_getTranslationUnitCursorType>(
      'clang_hook_getTranslationUnitCursor');
  return _getTranslationUnitCursorSymbol(tu);
}

clang_hook_disposeCursorType _disposeCursorSymbol;
void disposeCursor(Pointer<Void> data) {
  _disposeCursorSymbol ??= libclang.lookupFunction<
      clang_hook_disposeCursorNativeType,
      clang_hook_disposeCursorType>('clang_hook_disposeCursor');
  _disposeCursorSymbol(data);
}

clang_hook_getCursorKindType _getCursorKindSymbol;
int getCursorKind(Pointer<Void> cursor) {
  _getCursorKindSymbol ??= libclang.lookupFunction<
      clang_hook_getCursorKindNativeType,
      clang_hook_getCursorKindType>('clang_hook_getCursorKind');
  return _getCursorKindSymbol(cursor);
}

clang_hook_getCursorKindSpellingType _getCursorKindSpellingSymbol;
Pointer<Void> getCursorKindSpelling(int kind) {
  _getCursorKindSpellingSymbol ??= libclang.lookupFunction<
      clang_hook_getCursorKindSpellingNativeType,
      clang_hook_getCursorKindSpellingType>('clang_hook_getCursorKindSpelling');
  return _getCursorKindSpellingSymbol(kind);
}

clang_hook_getCursorSpellingType _getCursorSpellingSymbol;
Pointer<Void> getCursorSpelling(Pointer<Void> cursor) {
  _getCursorSpellingSymbol ??= libclang.lookupFunction<
      clang_hook_getCursorSpellingNativeType,
      clang_hook_getTypeSpellingType>('clang_hook_getCursorSpelling');
  return _getCursorSpellingSymbol(cursor);
}

clang_hook_disposeStringType _disposeStringSymbol;
void disposeString(Pointer<Void> data) {
  _disposeStringSymbol ??= libclang.lookupFunction<
      clang_hook_disposeStringNativeType,
      clang_hook_disposeStringType>('clang_hook_disposeString');
  _disposeStringSymbol(data);
}

clang_hook_getCStringType _getCStringSymbol;
Pointer<Utf8> getCString(Pointer<Void> clangString) {
  _getCStringSymbol ??= libclang.lookupFunction<clang_hook_getCStringNativeType,
      clang_hook_getCStringType>('clang_hook_getCString');
  return _getCStringSymbol(clangString);
}

clang_hook_getCursorTypeType _getCursorTypeSymbol;
Pointer<Void> getCursorType(Pointer<Void> cursor) {
  _getCursorTypeSymbol ??= libclang.lookupFunction<
      clang_hook_getCursorTypeNativeType,
      clang_hook_getCursorTypeType>('clang_hook_getCursorType');
  return _getCursorTypeSymbol(cursor);
}

clang_hook_disposeTypeType _disposeTypeSymbol;
void disposeType(Pointer<Void> data) {
  _disposeTypeSymbol ??= libclang.lookupFunction<
      clang_hook_disposeTypeNativeType,
      clang_hook_disposeTypeType>('clang_hook_disposeType');
  _disposeTypeSymbol(data);
}

clang_hook_getTypeSpellingType _getTypeSpellingSymbol;
Pointer<Void> getTypeSpelling(Pointer<Void> type) {
  _getTypeSpellingSymbol ??= libclang.lookupFunction<
      clang_hook_getTypeSpellingNativeType,
      clang_hook_getTypeSpellingType>('clang_hook_getTypeSpelling');
  return _getTypeSpellingSymbol(type);
}

clang_hook_Cursor_isMacroBuiltinType _isMacroBuiltinSymbol;
int isMacroBuiltin(Pointer<Void> cursor) {
  _isMacroBuiltinSymbol ??= libclang.lookupFunction<
      clang_hook_Cursor_isMacroBuiltinNativeType,
      clang_hook_Cursor_isMacroBuiltinType>('clang_hook_Cursor_isMacroBuiltin');
  return _isMacroBuiltinSymbol(cursor);
}

clang_hook_Cursor_isMacroFunctionLikeType _isMacroFunctionLikeSymbol;
int isMacroFunctionLike(Pointer<Void> cursor) {
  _isMacroFunctionLikeSymbol ??= libclang.lookupFunction<
          clang_hook_Cursor_isMacroFunctionLikeNativeType,
          clang_hook_Cursor_isMacroFunctionLikeType>(
      'clang_hook_Cursor_isMacroFunctionLike');
  return _isMacroFunctionLikeSymbol(cursor);
}

clang_hook_getCursorLocationType _getCursorLocationSymbol;
Pointer<Void> getCursorLocation(Pointer<Void> cursor) {
  _getCursorLocationSymbol ??= libclang.lookupFunction<
      clang_hook_getCursorLocationNativeType,
      clang_hook_getCursorLocationType>('clang_hook_getCursorLocation');
  return _getCursorLocationSymbol(cursor);
}

clang_hook_Location_isFromMainFileType _locationIsFromMainFileSymbol;
int locationIsFromMainFile(Pointer<Void> location) {
  _locationIsFromMainFileSymbol ??= libclang.lookupFunction<
          clang_hook_Location_isFromMainFileNativeType,
          clang_hook_Location_isFromMainFileType>(
      'clang_hook_Location_isFromMainFile');
  return _locationIsFromMainFileSymbol(location);
}

clang_hook_disposeSourceLocationType _disposeLocationSymbol;
void disposeLocation(Pointer<Void> data) {
  _disposeLocationSymbol ??= libclang.lookupFunction<
      clang_hook_disposeSourceLocationNativeType,
      clang_hook_disposeSourceLocationType>('clang_hook_disposeSourceLocation');
  _disposeLocationSymbol(data);
}

clang_hook_visitChildrenType _visitChildrenSymbol;
int visitChildren(
    Pointer<Void> cursor,
    Pointer<NativeFunction<CXCursorVisitorHookNative>> visitor,
    Pointer<Void> data) {
  _visitChildrenSymbol ??= libclang.lookupFunction<
      clang_hook_visitChildrenNativeType,
      clang_hook_visitChildrenType>('clang_hook_visitChildren');
  return _visitChildrenSymbol(cursor, visitor, data);
}

clang_getNumDiagnosticsType _getNumDiagnosticsSymbol;
int getNumDiagnostics(Pointer<Void> tu) {
  _getNumDiagnosticsSymbol ??= libclang.lookupFunction<
      clang_getNumDiagnosticsNativeType,
      clang_getNumDiagnosticsType>('clang_getNumDiagnostics');
  return _getNumDiagnosticsSymbol(tu);
}

clang_getDiagnosticType _getDiagnosticSymbol;
Pointer<Void> getDiagnostic(Pointer<Void> tu, int index) {
  _getDiagnosticSymbol ??= libclang.lookupFunction<
      clang_getDiagnosticNativeType,
      clang_getDiagnosticType>('clang_getDiagnostic');
  return _getDiagnosticSymbol(tu, index);
}

clang_disposeDiagnosticType _disposeDiagnosticSymbol;
void disposeDiagnostic(Pointer<Void> diagnostic) {
  _disposeDiagnosticSymbol ??= libclang.lookupFunction<
      clang_disposeDiagnosticNativeType,
      clang_disposeDiagnosticType>('clang_disposeDiagnostic');
  _disposeDiagnosticSymbol(diagnostic);
}

clang_getDiagnosticSeverityType _getDiagnosticSeveritySymbol;
int getDiagnosticSeverity(Pointer<Void> diagnostic) {
  _getDiagnosticSeveritySymbol ??= libclang.lookupFunction<
      clang_getDiagnosticSeverityNativeType,
      clang_getDiagnosticSeverityType>('clang_getDiagnosticSeverity');
  return _getDiagnosticSeveritySymbol(diagnostic);
}

clang_hook_formatDiagnosticType _formatDiagnosticSymbol;
Pointer<Void> formatDiagnostic(Pointer<Void> diagnostic, int options) {
  _formatDiagnosticSymbol ??= libclang.lookupFunction<
      clang_hook_formatDiagnosticNativeType,
      clang_hook_formatDiagnosticType>('clang_hook_formatDiagnostic');
  return _formatDiagnosticSymbol(diagnostic, options);
}

clang_defaultDiagnosticDisplayOptionsType
    _defaultDiagnosticDisplayOptionsSymbol;
int defaultDiagnosticDisplayOptions() {
  _defaultDiagnosticDisplayOptionsSymbol ??= libclang.lookupFunction<
          clang_defaultDiagnosticDisplayOptionsNativeType,
          clang_defaultDiagnosticDisplayOptionsType>(
      'clang_defaultDiagnosticDisplayOptions');
  return _defaultDiagnosticDisplayOptionsSymbol();
}

clang_getCursorLanguageType _getCursorLanguageSymbol;
int getCursorLanguage(Pointer<Void> cursor) {
  _getCursorLanguageSymbol ??= libclang.lookupFunction<
      clang_getCursorLanguageNativeType,
      clang_getCursorLanguageType>('clang_getCursorLanguage');
  return _getCursorLanguageSymbol(cursor);
}

clang_hook_isFunctionTypeVariadicType _isFunctionTypeVariadicSymbol;
int isFunctionTypeVariadic(Pointer<Void> type) {
  _isFunctionTypeVariadicSymbol ??= libclang.lookupFunction<
          clang_hook_isFunctionTypeVariadicNativeType,
          clang_hook_isFunctionTypeVariadicType>(
      'clang_hook_isFunctionTypeVariadic');
  return _isFunctionTypeVariadicSymbol(type);
}

clang_hook_Cursor_getNumArgumentsType _getNumArgumentsSymbol;
int getNumArguments(Pointer<Void> cursor) {
  _getNumArgumentsSymbol ??= libclang.lookupFunction<
          clang_hook_Cursor_getNumArgumentsNativeType,
          clang_hook_Cursor_getNumArgumentsType>(
      'clang_hook_Cursor_getNumArguments');
  return _getNumArgumentsSymbol(cursor);
}

clang_hook_Cursor_getArgumentType _getArgumentSymbol;
Pointer<Void> getArgument(Pointer<Void> cursor, int index) {
  _getArgumentSymbol ??= libclang.lookupFunction<
      clang_hook_Cursor_getArgumentNativeType,
      clang_hook_Cursor_getArgumentType>('clang_hook_Cursor_getArgument');
  return _getArgumentSymbol(cursor, index);
}

clang_hook_getResultTypeType _getResultTypeSymbol;
Pointer<Void> getResultType(Pointer<Void> type) {
  _getResultTypeSymbol ??= libclang.lookupFunction<
      clang_hook_getResultTypeNativeType,
      clang_hook_getResultTypeType>('clang_hook_getResultType');
  return _getResultTypeSymbol(type);
}

clang_hook_getTypeKindType _getTypeKindSymbol;
int getTypeKind(Pointer<Void> type) {
  _getTypeKindSymbol ??= libclang.lookupFunction<
      clang_hook_getTypeKindNativeType,
      clang_hook_getTypeKindType>('clang_hook_getTypeKind');
  return _getTypeKindSymbol(type);
}

clang_hook_getCanonicalTypeType _getCanonicalTypeSymbol;
Pointer<Void> getCanonicalType(Pointer<Void> type) {
  _getCanonicalTypeSymbol ??= libclang.lookupFunction<
      clang_hook_getCanonicalTypeNativeType,
      clang_hook_getCanonicalTypeType>('clang_hook_getCanonicalType');
  return _getCanonicalTypeSymbol(type);
}

clang_hook_Type_getSizeOfType _getSizeOfSymbol;
int getSizeOf(Pointer<Void> type) {
  _getSizeOfSymbol ??= libclang.lookupFunction<
      clang_hook_Type_getSizeOfNativeType,
      clang_hook_Type_getSizeOfType>('clang_hook_Type_getSizeOf');
  return _getSizeOfSymbol(type);
}

clang_hook_isConstQualifiedTypeType _isConstQualifiedTypeSymbol;
int isConstQualifiedType(Pointer<Void> type) {
  _isConstQualifiedTypeSymbol ??= libclang.lookupFunction<
      clang_hook_isConstQualifiedTypeNativeType,
      clang_hook_isConstQualifiedTypeType>('clang_hook_isConstQualifiedType');
  return _isConstQualifiedTypeSymbol(type);
}

clang_hook_getEnumConstantDeclValueType _getEnumConstantValueSymbol;
int getEnumConstantValue(Pointer<Void> cursor) {
  _getEnumConstantValueSymbol ??= libclang.lookupFunction<
          clang_hook_getEnumConstantDeclValueNativeType,
          clang_hook_getEnumConstantDeclValueType>(
      'clang_hook_getEnumConstantDeclValue');
  return _getEnumConstantValueSymbol(cursor);
}

clang_hook_Type_getNamedTypeType _getNamedTypeSymbol;
Pointer<Void> getNamedType(Pointer<Void> type) {
  _getNamedTypeSymbol ??= libclang.lookupFunction<
      clang_hook_Type_getNamedTypeNativeType,
      clang_hook_Type_getNamedTypeType>('clang_hook_Type_getNamedType');
  return _getNamedTypeSymbol(type);
}

clang_hook_getNumArgTypesType _getNumArgTypesSymbol;
int getNumArgTypes(Pointer<Void> type) {
  _getNumArgTypesSymbol ??= libclang.lookupFunction<clang_hook_getNumArgTypesNativeType, clang_hook_getNumArgTypesType>('clang_hook_getNumArgTypes');
  return _getNumArgTypesSymbol(type);
}

clang_hook_getArgTypeType _getArgTypeSymbol;
Pointer<Void> getArgType(Pointer<Void> type, int i) {
  _getArgTypeSymbol ??= libclang.lookupFunction<clang_hook_getArgTypeNativeType, clang_hook_getArgTypeType>('clang_hook_getArgType');
  return _getArgTypeSymbol(type, i);
}

clang_hook_getPointeeTypeType _getPointeeTypeSymbol;
Pointer<Void> getPointeeType(Pointer<Void> type) {
  _getPointeeTypeSymbol ??= libclang.lookupFunction<clang_hook_getPointeeTypeNativeType, clang_hook_getPointeeTypeType>('clang_hook_getPointeeType');
  return _getPointeeTypeSymbol(type);
}
