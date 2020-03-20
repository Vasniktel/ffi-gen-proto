#ifndef LIBCLANG_HOOKS_H
#define LIBCLANG_HOOKS_H

#include <clang-c/Index.h>

typedef enum CXChildVisitResult (*CXCursorVisitorHook)(CXCursor* cursor, CXCursor* parent, CXClientData data);

unsigned clang_hook_visitChildren(CXCursor* cursor, CXCursorVisitorHook visitor, CXClientData data);
CXCursor* clang_hook_getTranslationUnitCursor(CXTranslationUnit tu);
void clang_hook_disposeCursor(CXCursor* cursor);

CXString* clang_hook_getCursorSpelling(CXCursor* cursor);
CXString* clang_hook_getCursorKindSpelling(enum CXCursorKind kind);
CXString* clang_hook_getTypeSpelling(CXType* type);
void clang_hook_disposeString(CXString* string);
const char* clang_hook_getCString(CXString* string);

unsigned clang_hook_Cursor_isMacroBuiltin(CXCursor* cursor);
unsigned clang_hook_Cursor_isMacroFunctionLike(CXCursor* cursor);

enum CXCursorKind clang_hook_getCursorKind(CXCursor* cursor);
CXType* clang_hook_getCursorType(CXCursor* cursor);
void clang_hook_disposeType(CXType* type);

CXSourceLocation* clang_hook_getCursorLocation(CXCursor* cursor);
int clang_hook_Location_isFromMainFile(CXSourceLocation* location);
void clang_hook_disposeSourceLocation(CXSourceLocation* location);

CXString* clang_hook_formatDiagnostic(CXDiagnostic diagnostic, unsigned options);

unsigned clang_hook_isFunctionTypeVariadic(CXType* type);

int clang_hook_Cursor_getNumArguments(CXCursor* cursor);
CXCursor* clang_hook_Cursor_getArgument(CXCursor* cursor, unsigned i);

CXType* clang_hook_getResultType(CXType* type);

enum CXTypeKind clang_hook_getTypeKind(CXType* type);

CXType* clang_hook_getCanonicalType(CXType* type);

long long clang_hook_Type_getSizeOf(CXType* type);

unsigned clang_hook_isConstQualifiedType(CXType* type);

long long clang_hook_getEnumConstantDeclValue(CXCursor* cursor);

CXType* clang_hook_Type_getNamedType(CXType* type);

int clang_hook_getNumArgTypes(CXType* type);
CXType* clang_hook_getArgType(CXType* type, unsigned i);

CXType* clang_hook_getPointeeType(CXType* type);

#endif
