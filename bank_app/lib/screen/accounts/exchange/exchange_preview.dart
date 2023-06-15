import 'dart:convert';
import 'package:http/http.dart' as http;


// move provider from there and extract model

class ExchangePreview {
  final String From;
  final String To;
  final int AmountToSell;
  ExchangePreview(this.From,this.To,this.AmountToSell);

    Map<String, dynamic> toJson() {
    return {
      'From': From,
      'To': To,
      'AmountToSell': AmountToSell,
    };
  }
}

Future<http.Response> previewExchange(ExchangePreview exchangePreview) {
  return http.post(
    Uri.parse('http://localhost:5000/previewExchange'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(exchangePreview.toJson()),
  );
}
