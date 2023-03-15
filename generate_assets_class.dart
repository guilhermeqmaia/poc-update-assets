import 'dart:io';

import 'generate_group_properties.dart';
import 'generate_groups_class.dart';

void generateAssetsClass(String className, String fileName) {
  List<String> banks = bankProperties();
  List<String> cryptos = cryptoProperties();
  List<String> stocks = stockProperties();
  generateClass(banks, 'BankGroup', 'bank_group.dart');
  generateClass(cryptos, 'CryptoGroup', 'crypto_group.dart');
  generateClass(stocks, 'StockGroup', 'stock_group.dart');

  final List<Map<String, dynamic>> fieldsList = [
    {
      'propName': 'bank',
      'className': 'BankGroup',
    },
    {
      'propName': 'crypto',
      'className': 'CryptoGroup',
    },
    {
      'propName': 'stock',
      'className': 'StockGroup',
    },
  ];

  final List<List<String>> groupsFields = [banks, cryptos, stocks];

  final fields = fieldsList
      .map((e) => 'final ${e['className']} ${e['propName']};')
      .join('\n  ');

  final constructorParams = '''
    ${fieldsList.map((e) {
    return '''this.${e['propName']}: const ${e['className']}(
      ${groupsFields[fieldsList.indexOf(e)].map((asset) {
      final String fileExtension =
          e['propName'] == 'stock' ? '@3x.png' : '.svg';
      final prop =
          e['propName'] == 'bank' ? asset.substring(1) : asset.toUpperCase();

      return "$asset: '${e['propName']}/$prop$fileExtension'";
    }).join(',\n      ')}
    ),
    ''';
  }).join('')}
  ''';

  final constructor = '''
const $className ({
$constructorParams
});
  ''';

  final classDefinition = '''
import 'groups/bank_group.dart';
import 'groups/crypto_group.dart';
import 'groups/stock_group.dart';

class $className {

  $fields

  $constructor
  }
  ''';

  final file = File('assets/$fileName');
  file.writeAsStringSync(classDefinition);
}
