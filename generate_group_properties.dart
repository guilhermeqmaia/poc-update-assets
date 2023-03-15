import 'dart:io';

List<String> bankProperties() {
  final bankDir = Directory('bank');
  final bankFiles = bankDir.listSync();
  List<String> bankProperties = [];
  bankFiles.forEach((element) {
    final bank = element.path.substring(5, element.path.length - 4);
    bankProperties.add('b$bank');
  });
  return bankProperties;
}

List<String> cryptoProperties() {
  final cryptoDir = Directory('crypto');
  final cryptoFiles = cryptoDir.listSync();
  List<String> cryptoProperties = [];
  cryptoFiles.forEach((element) {
    final crypto = element.path.substring(7, (element.path.length - 4));
    cryptoProperties.add(crypto.toLowerCase());
  });
  return cryptoProperties;
}

List<String> stockProperties() {
  final stockDir = Directory('stock');
  final stockFiles = stockDir.listSync();
  List<String> stockProperties = [];
  stockFiles.where((file) => file.path.contains("@3x")).forEach((element) {
    final stock = element.path.substring(6, (element.path.length - 7));
    stockProperties.add(stock.toLowerCase());
  });
  return stockProperties;
}
