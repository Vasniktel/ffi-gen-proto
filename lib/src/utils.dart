import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

List<String> stringListFromConstant(ConstantReader reader) =>
    reader.listValue.map((val) => val.toStringValue()).toList() ?? [];

abstract class NameFilter {
  bool isValid(String name);
}

class Only implements NameFilter {
  final List<String> _names;
  const Only(this._names);

  Only._fromConstant(ConstantReader reader)
      : _names = stringListFromConstant(reader.read('_names'));

  @override
  bool isValid(String name) => _names.contains(name);
}

class AllExcept implements NameFilter {
  final List<String> _names;
  const AllExcept(this._names);

  AllExcept._fromConstant(ConstantReader reader)
      : _names = stringListFromConstant(reader.read('_names'));

  @override
  bool isValid(String name) => !_names.contains(name);
}

NameFilter nameFilterFromConstant(ConstantReader reader) {
  if (reader.instanceOf(TypeChecker.fromRuntime(Only))) {
    return Only._fromConstant(reader);
  } else {
    return AllExcept._fromConstant(reader);
  }
}

Library libraryFromConstant(ConstantReader reader) {
  return Library(
    headers: stringListFromConstant(reader.read('headers')),
    //include: nameFilterFromConstant(reader.read('include')),
    //parse: nameFilterFromConstant(reader.read('parse')),
    configs: stringListFromConstant(reader.read('configs')),
  );
}
