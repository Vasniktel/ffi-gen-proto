#include <stdlib.h>
#include "libclang_hooks.h"

static CXCursorVisitorHook visitor_hook;

static enum CXChildVisitResult Visitor(CXCursor cursor, CXCursor parent, CXClientData data) {
  return visitor_hook(&cursor, &parent, data);
}

unsigned clang_hook_visitChildren(CXCursor* cursor, CXCursorVisitorHook visitor, CXClientData data) {
  CXCursorVisitorHook previous = visitor_hook;
  visitor_hook = visitor;
  unsigned result = clang_visitChildren(*cursor, Visitor, data);
  visitor_hook = previous;
  return result;
}

static CXString* AllocateCXString(CXString value) {
  CXString* result = malloc(sizeof(CXString));
  *result = value;
  return result;
}

static CXCursor* AllocateCXCursor(CXCursor value) {
  CXCursor* result = malloc(sizeof(CXCursor));
  *result = value;
  return result;
}

static CXType* AllocateCXType(CXType value) {
  CXType* result = malloc(sizeof(CXType));
  *result = value;
  return result;
}

CXCursor* clang_hook_getTranslationUnitCursor(CXTranslationUnit tu) {
  return AllocateCXCursor(clang_getTranslationUnitCursor(tu));
}

void clang_hook_disposeCursor(CXCursor* cursor) {
  free(cursor);
}

CXString* clang_hook_getCursorSpelling(CXCursor* cursor) {
  return AllocateCXString(clang_getCursorSpelling(*cursor));
}

CXString* clang_hook_getCursorKindSpelling(enum CXCursorKind kind) {
  return AllocateCXString(clang_getCursorKindSpelling(kind));
}

CXString* clang_hook_getTypeSpelling(CXType* type) {
  return AllocateCXString(clang_getTypeSpelling(*type));
}

void clang_hook_disposeString(CXString* string) {
  clang_disposeString(*string);
  free(string);
}

const char* clang_hook_getCString(CXString* string) {
  return clang_getCString(*string);
}

unsigned clang_hook_Cursor_isMacroBuiltin(CXCursor* cursor) {
  return clang_Cursor_isMacroBuiltin(*cursor);
}

unsigned clang_hook_Cursor_isMacroFunctionLike(CXCursor* cursor) {
  return clang_Cursor_isMacroFunctionLike(*cursor);
}

enum CXCursorKind clang_hook_getCursorKind(CXCursor* cursor) {
  return clang_getCursorKind(*cursor);
}

CXType* clang_hook_getCursorType(CXCursor* cursor) {
  return AllocateCXType(clang_getCursorType(*cursor));
}

void clang_hook_disposeType(CXType* type) {
  free(type);
}

CXSourceLocation* clang_hook_getCursorLocation(CXCursor* cursor) {
  CXSourceLocation* result = malloc(sizeof(CXSourceLocation));
  *result = clang_getCursorLocation(*cursor);
  return result;
}

int clang_hook_Location_isFromMainFile(CXSourceLocation* location) {
  return clang_Location_isFromMainFile(*location);
}

void clang_hook_disposeSourceLocation(CXSourceLocation* location) {
  free(location);
}

CXString* clang_hook_formatDiagnostic(CXDiagnostic diagnostic, unsigned options) {
  return AllocateCXString(clang_formatDiagnostic(diagnostic, options));
}

unsigned clang_hook_isFunctionTypeVariadic(CXType* type) {
  return clang_isFunctionTypeVariadic(*type);
}

int clang_hook_Cursor_getNumArguments(CXCursor* cursor) {
  return clang_Cursor_getNumArguments(*cursor);
}

CXCursor* clang_hook_Cursor_getArgument(CXCursor* cursor, unsigned i) {
  return AllocateCXCursor(clang_Cursor_getArgument(*cursor, i));
}

CXType* clang_hook_getResultType(CXType* type) {
  return AllocateCXType(clang_getResultType(*type));
}

enum CXTypeKind clang_hook_getTypeKind(CXType* type) {
  return type->kind;
}

CXType* clang_hook_getCanonicalType(CXType* type) {
  return AllocateCXType(clang_getCanonicalType(*type));
}

long long clang_hook_Type_getSizeOf(CXType* type) {
  return clang_Type_getSizeOf(*type);
}

unsigned clang_hook_isConstQualifiedType(CXType* type) {
  return clang_isConstQualifiedType(*type);
}

long long clang_hook_getEnumConstantDeclValue(CXCursor* cursor) {
  return clang_getEnumConstantDeclValue(*cursor);
}

CXType* clang_hook_Type_getNamedType(CXType* type) {
  return AllocateCXType(clang_Type_getNamedType(*type));
}

int clang_hook_getNumArgTypes(CXType* type) {
  return clang_getNumArgTypes(*type);
}

CXType* clang_hook_getArgType(CXType* type, unsigned i) {
  return AllocateCXType(clang_getArgType(*type, i));
}

CXType* clang_hook_getPointeeType(CXType* type) {
  return AllocateCXType(clang_getPointeeType(*type));
}
