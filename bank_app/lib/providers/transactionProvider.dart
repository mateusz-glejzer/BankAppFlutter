import 'dart:convert';
import 'dart:io';

import 'package:bank_app/Transactions/transactionDto.dart';
import 'package:bank_app/Transactions/transactionViewModel.dart';
Future<List<TransactionViewModel>> getTransations() async {
  final client = HttpClient();
  try {
    HttpClientRequest request = await client.get('localhost', 5000, '/');
    HttpClientResponse response = await request.close();
    final stringData = await response.transform(utf8.decoder).join();
    List<dynamic> jsonResponse = jsonDecode(stringData);
    print(jsonResponse);
    List<TransactionViewModel> result = [];

    for (var element in jsonResponse) {
      
      final transactionDto = transaction_dto.fromJson(element as Map<String, dynamic>);
      final dateSplitted = transactionDto.date.split('.');
      final date = DateTime(int.parse(dateSplitted[2]), int.parse(dateSplitted[1]),
          int.parse(dateSplitted[0]));
      result.add(
          TransactionViewModel(transactionDto.name, date, transactionDto.sum));
    }

    return result;
  } finally {
    client.close();
  }
}
