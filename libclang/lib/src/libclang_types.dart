import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef clang_createIndexNativeType = Pointer<Void> Function(Int32, Int32);
typedef clang_createIndexType = Pointer<Void> Function(int, int);

typedef clang_disposeIndexNativeType = Void Function(Pointer<Void>);
typedef clang_disposeIndexType = void Function(Pointer<Void>);

typedef clang_parseTranslationUnitNativeType = Pointer<Void> Function(
    Pointer<Void>,
    Pointer<Utf8>,
    Pointer<Pointer<Utf8>>,
    Int32,
    Pointer<Void>,
    Uint32,
    Uint32);
typedef clang_parseTranslationUnitType = Pointer<Void> Function(
    Pointer<Void>, Pointer<Utf8>, Pointer<Pointer<Utf8>>, int, Pointer<Void>, int, int);

typedef clang_disposeTranslationUnitNativeType = Void Function(Pointer<Void>);
typedef clang_disposeTranslationUnitType = void Function(Pointer<Void>);

typedef CXCursorVisitorHookNative = Int32 Function(
    Pointer<Void>, Pointer<Void>, Pointer<Void>);
typedef CXCursorVisitorHook = int Function(
    Pointer<Void>, Pointer<Void>, Pointer<Void>);

typedef clang_hook_visitChildrenNativeType = Uint32 Function(Pointer<Void>,
    Pointer<NativeFunction<CXCursorVisitorHookNative>>, Pointer<Void>);
typedef clang_hook_visitChildrenType = int Function(Pointer<Void>,
    Pointer<NativeFunction<CXCursorVisitorHookNative>>, Pointer<Void>);

typedef clang_hook_getTranslationUnitCursorNativeType = Pointer<Void> Function(
    Pointer<Void>);
// Unfortunately, Dart doesn't support typedefs for non-function types (there is an issue though)
typedef clang_hook_getTranslationUnitCursorType = Pointer<Void> Function(
    Pointer<Void>);

typedef clang_hook_disposeCursorNativeType = Void Function(Pointer<Void>);
typedef clang_hook_disposeCursorType = void Function(Pointer<Void>);

typedef clang_hook_getCursorSpellingNativeType = Pointer<Void> Function(
    Pointer<Void>);
typedef clang_hook_getCursorSpellingType = Pointer<Void> Function(
    Pointer<Void>);

typedef clang_hook_getCursorKindSpellingNativeType = Pointer<Void> Function(
    Int32);
typedef clang_hook_getCursorKindSpellingType = Pointer<Void> Function(int);

typedef clang_hook_getTypeSpellingNativeType = Pointer<Void> Function(
    Pointer<Void>);
typedef clang_hook_getTypeSpellingType = Pointer<Void> Function(Pointer<Void>);

typedef clang_hook_disposeStringNativeType = Void Function(Pointer<Void>);
typedef clang_hook_disposeStringType = void Function(Pointer<Void>);

typedef clang_hook_getCStringNativeType = Pointer<Utf8> Function(Pointer<Void>);
typedef clang_hook_getCStringType = Pointer<Utf8> Function(Pointer<Void>);

typedef clang_hook_Cursor_isMacroBuiltinNativeType = Uint32 Function(
    Pointer<Void>);
typedef clang_hook_Cursor_isMacroBuiltinType = int Function(Pointer<Void>);

typedef clang_hook_Cursor_isMacroFunctionLikeNativeType = Uint32 Function(
    Pointer<Void>);
typedef clang_hook_Cursor_isMacroFunctionLikeType = int Function(Pointer<Void>);

typedef clang_hook_getCursorKindNativeType = Int32 Function(Pointer<Void>);
typedef clang_hook_getCursorKindType = int Function(Pointer<Void>);

typedef clang_hook_getCursorTypeNativeType = Pointer<Void> Function(
    Pointer<Void>);
typedef clang_hook_getCursorTypeType = Pointer<Void> Function(Pointer<Void>);

typedef clang_hook_disposeTypeNativeType = Void Function(Pointer<Void>);
typedef clang_hook_disposeTypeType = void Function(Pointer<Void>);

typedef clang_hook_getCursorLocationNativeType = Pointer<Void> Function(
    Pointer<Void>);
typedef clang_hook_getCursorLocationType = Pointer<Void> Function(
    Pointer<Void>);

typedef clang_hook_Location_isFromMainFileNativeType = Int32 Function(
    Pointer<Void>);
typedef clang_hook_Location_isFromMainFileType = int Function(Pointer<Void>);

typedef clang_hook_disposeSourceLocationNativeType = Void Function(
    Pointer<Void>);
typedef clang_hook_disposeSourceLocationType = void Function(Pointer<Void>);

typedef clang_getNumDiagnosticsNativeType = Uint32 Function(Pointer<Void>);
typedef clang_getNumDiagnosticsType = int Function(Pointer<Void>);

typedef clang_getDiagnosticNativeType = Pointer<Void> Function(
    Pointer<Void>, Uint32);
typedef clang_getDiagnosticType = Pointer<Void> Function(Pointer<Void>, int);

typedef clang_disposeDiagnosticNativeType = Void Function(Pointer<Void>);
typedef clang_disposeDiagnosticType = void Function(Pointer<Void>);

typedef clang_getDiagnosticSeverityNativeType = Int32 Function(Pointer<Void>);
typedef clang_getDiagnosticSeverityType = int Function(Pointer<Void>);

typedef clang_hook_formatDiagnosticNativeType = Pointer<Void> Function(
    Pointer<Void>, Uint32);
typedef clang_hook_formatDiagnosticType = Pointer<Void> Function(
    Pointer<Void>, int);

typedef clang_defaultDiagnosticDisplayOptionsNativeType = Uint32 Function();
typedef clang_defaultDiagnosticDisplayOptionsType = int Function();

typedef clang_getCursorLanguageNativeType = Int32 Function(Pointer<Void>);
typedef clang_getCursorLanguageType = int Function(Pointer<Void>);

typedef clang_hook_isFunctionTypeVariadicNativeType = Uint32 Function(Pointer<Void>);
typedef clang_hook_isFunctionTypeVariadicType = int Function(Pointer<Void>);

typedef clang_hook_Cursor_getNumArgumentsNativeType = Int32 Function(Pointer<Void>);
typedef clang_hook_Cursor_getNumArgumentsType = int Function(Pointer<Void>);

typedef clang_hook_Cursor_getArgumentNativeType = Pointer<Void> Function(Pointer<Void>, Uint32);
typedef clang_hook_Cursor_getArgumentType = Pointer<Void> Function(Pointer<Void>, int);

typedef clang_hook_getResultTypeNativeType = Pointer<Void> Function(Pointer<Void>);
typedef clang_hook_getResultTypeType = Pointer<Void> Function(Pointer<Void>);

typedef clang_hook_getTypeKindNativeType = Int32 Function(Pointer<Void>);
typedef clang_hook_getTypeKindType = int Function(Pointer<Void>);

typedef clang_hook_getCanonicalTypeNativeType = Pointer<Void> Function(Pointer<Void>);
typedef clang_hook_getCanonicalTypeType = Pointer<Void> Function(Pointer<Void>);

typedef clang_hook_Type_getSizeOfNativeType = Int64 Function(Pointer<Void>);
typedef clang_hook_Type_getSizeOfType = int Function(Pointer<Void>);

typedef clang_hook_isConstQualifiedTypeNativeType = Uint32 Function(Pointer<Void>);
typedef clang_hook_isConstQualifiedTypeType = int Function(Pointer<Void>);

typedef clang_hook_getEnumConstantDeclValueNativeType = Int64 Function(Pointer<Void>);
typedef clang_hook_getEnumConstantDeclValueType = int Function(Pointer<Void>);

typedef clang_hook_Type_getNamedTypeNativeType = Pointer<Void> Function(Pointer<Void>);
typedef clang_hook_Type_getNamedTypeType = Pointer<Void> Function(Pointer<Void>);

typedef clang_hook_getNumArgTypesNativeType = Int32 Function(Pointer<Void>);
typedef clang_hook_getNumArgTypesType = int Function(Pointer<Void>);

typedef clang_hook_getArgTypeNativeType = Pointer<Void> Function(Pointer<Void>, Uint32);
typedef clang_hook_getArgTypeType = Pointer<Void> Function(Pointer<Void>, int);

typedef clang_hook_getPointeeTypeNativeType = Pointer<Void> Function(Pointer<Void>);
typedef clang_hook_getPointeeTypeType = Pointer<Void> Function(Pointer<Void>);
