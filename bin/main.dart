import 'dart:io';

import 'package:build_cli_annotations/build_cli_annotations.dart';
import 'package:dado/dado.dart';
import 'package:io/io.dart';
import 'package:io/ansi.dart';

part 'main.g.dart';

@CliOptions()
class Options {
  @CliOption(abbr: 'add', help: 'Required. The name to use in the greeting.')
  String add;

  @CliOption(abbr: 'list', help: 'Required. The name to use in the greeting.')
  bool list;

  @CliOption(abbr: 'done', help: 'Required. The name to use in the greeting.')
  String done;

 @CliOption(defaultsTo: Action.add, abbr: 'l')
  Action displayAction;

 @CliOption(abbr: 'h', negatable: false, help: 'Prints usage information.')
  bool help;

  Options();
}

enum Action { add, list }

void main(List<String> args) {
 Options options;
 try {
   options = parseOptions(args);
 } on FormatException catch (e) {
    print(red.wrap(e.message));
    print('');
    _printUsage();
    exitCode = ExitCode.usage.code;
    return;
 }

 if (options.help) {
   _printUsage();
   return;
 } else if (options.add != null) {
   add(options.add);
 } else if (options.list) {
   list();
 } else if (options.done != null) {
   var number = int.parse(options.done);
   done(number);
 }
}

void _printUsage() {
  print('Usage: example/example.dar');
  print(_$parserForOptions.usage);
}
