import 'dart:convert';
import 'dart:io';
import 'package:bank_app/Transactions/transaction_dto.dart';
import 'package:bank_app/Transactions/transaction_model.dart';
import 'package:bank_app/model/currency_code.dart';

Future<List<TransactionViewModel>> getTransationsInternal(
    String currencyCode, String token) async {
  final client = HttpClient();
  try {
    HttpClientRequest request =
        await client.post('localhost', 5000, '/transfers');
    // Set the request headers to specify the content type as application/json
    request.headers.add('Content-Type', 'application/json');

    Map<String, dynamic> jsonRequest = {
      'token': token,
      'currencyCode': currencyCode
    };
    final jsonn = json.encode(jsonRequest);

    // Convert the loginData object to a JSON string
    // final loginDataJson = json.encode(jsonRequest);

    // Write the JSON data to the request body
    request.write(jsonn);
    HttpClientResponse response = await request.close();
    final stringData = await response.transform(utf8.decoder).join();
    List<dynamic> jsonResponse = jsonDecode(stringData);
    List<TransactionViewModel> result = [];

    for (var element in jsonResponse) {
      final transactionDto =
          TransactionDto.fromJson(element as Map<String, dynamic>);
      final dateSplitted = transactionDto.date.split('/');
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
  String token,
) async {
  var temp = transactions[from] ?? await getTransations(from, token);
  var sold = amountSold.toString();
  //connect backend
  temp!.add(TransactionViewModel("Exchange", DateTime.now(), "-$sold"));
  transactions[from] = temp;
  temp = transactions[to] ?? await getTransations(to, token);
  //connect backend
  temp!.add(TransactionViewModel(
      "Exchange", DateTime.now(), amountBought.toString()));
  transactions[to] = temp;
}

Future<List<TransactionViewModel>> getTransations(
    CurrencyCode currencyCode, String token) async {
  var currencyTransactions = transactions[currencyCode];
  if (currencyTransactions != null) {
    return currencyTransactions;
  }

  var result = await getTransationsInternal(currencyCode.name, token);
  transactions[currencyCode] = result;
  return result;
}
