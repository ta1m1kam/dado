import 'dart:io';

void list() {
  File('file.txt').readAsString().then((String contents) {
  print(contents);
 });
}

void add(String task) async {
  var file = File('file.txt');
  var hoge = await file.readAsString();
  var sink = file.openWrite();
  sink.write(hoge);
  sink.write(task + '\n');

  // Close the IOSink to free system resources.
  await sink.close();
}

