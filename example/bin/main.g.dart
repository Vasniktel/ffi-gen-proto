// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// LibraryGenerator
// **************************************************************************

//
// Symbols from test_lib/test_lib.h
//

const A = 0;
const B = 8;
const C = 16;

Pointer<Int32> _kSymbol;
int get k {
  _kSymbol ??= testlib.lookup<Int32>('k');
  return _kSymbol.value;
}

set k(int value) {
  _kSymbol ??= testlib.lookup<Int32>('k');
  _kSymbol.value = value;
}

typedef TD = Int32 Function(Int32, Int64, Int32);

Pointer<Pointer<NativeFunction<Int32 Function(Int32, Int64, Int32)>>> _tdSymbol;
Pointer<NativeFunction<Int32 Function(Int32, Int64, Int32)>> get td {
  _tdSymbol ??= testlib.lookup<
      Pointer<NativeFunction<Int32 Function(Int32, Int64, Int32)>>>('td');
  return _tdSymbol.value;
}

set td(Pointer<NativeFunction<Int32 Function(Int32, Int64, Int32)>> value) {
  _tdSymbol ??= testlib.lookup<
      Pointer<NativeFunction<Int32 Function(Int32, Int64, Int32)>>>('td');
  _tdSymbol.value = value;
}

Pointer<Double> _global_varSymbol;
double get global_var {
  _global_varSymbol ??= testlib.lookup<Double>('global_var');
  return _global_varSymbol.value;
}

typedef _testNativeType = Void Function(
    Int32, Int64, Uint8, Int8, Uint64, Float, Pointer<Int8>);
typedef _testType = void Function(
    int, int, int, int, int, double, Pointer<Int8>);

_testType _testSymbol;
void test(int a, int b, int c, int d, int e, double p, Pointer<Int8> str) {
  _testSymbol ??= testlib.lookupFunction<_testNativeType, _testType>('test');
  return _testSymbol(a, b, c, d, e, p, str);
}
