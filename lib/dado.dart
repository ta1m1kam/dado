import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:shell/shell.dart';

const undoneMark = '\x1b[32m\u2610\x1b[0m';
const doneMark = '\x1b[31m\u2611\x1b[0m';


void list() {
  final file = File('file.txt');
  Stream<List<int>> inputStream = file.openRead();

  inputStream
    .transform(utf8.decoder)
    .transform(LineSplitter())
    .listen((String line) {
      if (line.startsWith('-')) {
        line = line.replaceFirst('-', '');
        print('$doneMark $line');
      } else {
        print('$undoneMark $line');
      }
    },
    onDone: () { },
    onError: (e) { print(e.toString()); });
}

void add(String task) async {
  var file = File('file.txt');
  var current = await file.readAsString();
  var sink = file.openWrite();
  sink.write(current);
  sink.write(task + '\n');

  await sink.close();
}

void done(int number) {
  File('file2.txt').create(recursive: true);
  var newFile = File('file2.txt');
  var sink = newFile.openWrite();
  final file = File('file.txt');
  Stream<List<int>> inputStream = file.openRead();

  var cnt = 1;
  inputStream
    .transform(utf8.decoder)
    .transform(LineSplitter())
    .listen((String line) {
    if (cnt == number && !line.startsWith('-')) {
      sink.write('-$line\n');
    } else {
      sink.write('$line\n');
    }
    cnt += 1;
  },
    onDone: () { },
    onError: (e) { print(e.toString()); });

  Shell().start('rm', ['file2.txt']);
  newFile.rename('file.txt');
}
