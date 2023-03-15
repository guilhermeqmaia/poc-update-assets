import 'dart:io';

void generateClass(List<String> strings, String className, String fileName) {
  final fields = strings.map((s) => 'final String $s;').join('\n  ');

  final constructorParams =
      strings.map((s) => 'required this.$s').join(',\n    ');

  final constructor = '''
const $className({
    $constructorParams,
  });
  ''';

  final classDefinition = '''
class $className {
  $fields

  $constructor
}
  ''';

  final file = File("assets/groups/$fileName");
  file.writeAsStringSync(classDefinition);
}
