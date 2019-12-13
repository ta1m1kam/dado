part of 'main.dart';

T _$enumValueHelper<T>(Map<T, String> enumValues, String source) {
  if (source == null) {
    return null;
  }
  return enumValues.entries
    .singleWhere((e) => e.value == source,
    orElse: () => throw ArgumentError(
      '`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}'))
    .key;
}

Options _$parseOptionsResult(ArgResults result) =>
  Options()
    ..displayAction = _$enumValueHelper(
      _$ActionEnumMap, result['action'] as String)
    ..add = result['add'] as String
    ..list = result['list'] as bool
    ..help = result['help'] as bool;

const _$ActionEnumMap = <Action, String> {
  Action.add: 'add',
  Action.list: 'list'
};

ArgParser _$populateOptionsParser(ArgParser parser) => parser
  ..addOption('add', abbr: 'a', help: 'Required. The name to use in greeting.')
  ..addFlag('list', abbr: 'l', help: 'Required. The name to use in greeting.', negatable: false)
  ..addOption('action', abbr: 't', defaultsTo: 'list', allowed: ['add', 'list'])
  ..addFlag('help', abbr: 'h', help: 'Prints usage information.', negatable: false);

final _$parserForOptions = _$populateOptionsParser(ArgParser());

Options parseOptions(List<String> args) {
  final result = _$parserForOptions.parse(args);
  return _$parseOptionsResult(result);
}
