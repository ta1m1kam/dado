
import 'dart:io';

import 'package:io/ansi.dart';
import 'package:io/io.dart';
import 'package:build_cli_annotations/build_cli_annotations.dart';

part 'example.g.dart';

/// Annotation your option class with [CliOptions].
@CliOptions()
class Options {
  @CliOption(abbr: 'n', help: 'Required. The name to use in the greeting.')
  final String name;

  final bool nameWasParsed;

  bool yell;

  @CliOption(defaultsTo: Language.en, abbr: 'l')
  Language displayLanguage;

  @CliOption(negatable: false, help: 'Prints usage information.')
  bool help;

  Options(this.name, {this.nameWasParsed});
}

enum Language { en, es }

void main(List<String> args) {
  Options options;
  try {
    options = parseOptions(args);
    if (!options.nameWasParsed) {
      throw const FormatException('You must provide a name.');
    }
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
  }

  final buffer = StringBuffer();

  switch (options.displayLanguage) {
    case Language.en:
      buffer.write('Hello, ');
      break;
    case Language.es:
      buffer.write('¡Hola, ');
      break;
  }

  buffer.write(options.name);
  buffer.write('!');

  if (options.yell) {
    print(buffer.toString().toUpperCase());
  } else {
    print(buffer);
  }
}

void _printUsage() {
  print('Usage: example/example.dart [arguments]');
  print(_$parserForOptions.usage);
}
