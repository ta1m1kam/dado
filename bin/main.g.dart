part of 'main.dart';

Options _$parseOptionsResult(ArgResults result) =>
  Options()
    ..add = result['add'] as String
    ..list = result['list'] as bool
    ..done = result['done'] as String
    ..undone = result['undone'] as String
    ..remove = result['remove'] as String
    ..clean = result['clean'] as bool
    ..sort = result['sort'] as bool
    ..help = result['help'] as bool;

ArgParser _$populateOptionsParser(ArgParser parser) => parser
  ..addOption('add', abbr: 'a', help: 'Required. The name to use in greeting.')
  ..addFlag('list', abbr: 'l', help: 'Required. The name to use in greeting.', negatable: false)
  ..addOption('done', abbr: 'd', help: 'Required. The name to use in greeting.')
  ..addOption('undone', abbr: 'u', help: 'Required. The name to use in greeting.')
  ..addOption('remove', abbr: 'r', help: 'Required. The name to use in greeting.')
  ..addFlag('clean', abbr: 'c', help: 'Required. The name to use in greeting.')
  ..addFlag('sort', abbr: 's', help: 'Required. The name to use in greeting.')
  ..addFlag('help', abbr: 'h', help: 'Prints usage information.', negatable: false);

final _$parserForOptions = _$populateOptionsParser(ArgParser());

Options parseOptions(List<String> args) {
  final result = _$parserForOptions.parse(args);
  return _$parseOptionsResult(result);
}
