import 'dart:convert';
import 'dart:io';
import 'package:bank_app/Transactions/transaction_dto.dart';
import 'package:bank_app/Transactions/transaction_model.dart';
import 'package:bank_app/model/currency_code.dart';

Future<List<TransactionViewModel>> getTransationsInternal(
    CurrencyCode currencyCode) async {
  final client = HttpClient();
  try {
    HttpClientRequest request =
        await client.get('localhost', 5000, '/transfers/$currencyCode');
    HttpClientResponse response = await request.close();
    final stringData = await response.transform(utf8.decoder).join();
    List<dynamic> jsonResponse = jsonDecode(stringData);
    List<TransactionViewModel> result = [];

    for (var element in jsonResponse) {
      final transactionDto =
          TransactionDto.fromJson(element as Map<String, dynamic>);
      final dateSplitted = transactionDto.date.split('.');
      final date = DateTime(int.parse(dateSplitted[2]),
          int.parse(dateSplitted[1]), int.parse(dateSplitted[0]));
      result.add(
          TransactionViewModel(transactionDto.name, date, transactionDto.sum));
    }

    return result;
  } finally {
    client.close();
  }
}

//fake backend- only to mimic some logic to show to the study class Teacher

var transactions = new Map<CurrencyCode, List<TransactionViewModel>>();

Future<void> exchangeMoney(
  CurrencyCode from,
  CurrencyCode to,
  int amountSold,
  int amountBought,
) async {
  var temp = transactions[from] ?? await getTransations(from);
  var sold = amountSold.toString();
  temp!.add(
      TransactionViewModel("Exchange", DateTime.now(), "-$sold"));
  transactions[from] = temp;
  temp = transactions[to] ?? await getTransations(to);
  temp!.add(TransactionViewModel(
      "Exchange", DateTime.now(), amountBought.toString()));
  transactions[to] = temp;
}

Future<List<TransactionViewModel>> getTransations(
    CurrencyCode currencyCode) async {
  var currencyTransactions = transactions[currencyCode];
  if (currencyTransactions != null) {
    return currencyTransactions;
  }

  var result = await getTransationsInternal(currencyCode);
  transactions[currencyCode] = result;
  return result;
}
