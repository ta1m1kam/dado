part of 'main.dart';

Options _$parseOptionsResult(ArgResults result) =>
  Options()
    ..add = result['add'] as String
    ..list = result['list'] as bool
    ..done = result['done'] as String
    ..undone = result['undone'] as String
    ..remove = result['remove'] as String
    ..clean = result['clean'] as bool
    ..help = result['help'] as bool;

ArgParser _$populateOptionsParser(ArgParser parser) => parser
  ..addOption('add', abbr: 'a', help: 'add task to list')
  ..addFlag('list', abbr: 'l', help: 'watch task list', negatable: false)
  ..addOption('done', abbr: 'd', help: 'done task')
  ..addOption('undone', abbr: 'u', help: 'undone task')
  ..addOption('remove', abbr: 'r', help: 'remove task from list')
  ..addFlag('clean', abbr: 'c', help: 'clean done tasks from list', negatable: false)
  ..addFlag('help', abbr: 'h', help: 'prints usage information', negatable: false);

final _$parserForOptions = _$populateOptionsParser(ArgParser());

Options parseOptions(List<String> args) {
  final result = _$parserForOptions.parse(args);
  return _$parseOptionsResult(result);
}
