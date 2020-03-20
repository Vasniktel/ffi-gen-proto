import 'package:meta/meta.dart';
import 'utils.dart';

export 'utils.dart' show NameFilter, AllExcept, Only;

class Library {
  final List<String> headers;
  //final NameFilter include;
  //final NameFilter parse;
  final List<String> configs;
  //final String additionalSymbols;

  const Library({
    @required this.headers,
    //this.include = const AllExcept([]),
    //this.parse = const AllExcept([]),
    this.configs = const [],
    //this.additionalSymbols = '',
  });
}
