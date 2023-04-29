import 'package:bank_app/model/currency_code.dart';

class AccountTileModel {
  final CurrencyCode currencyCode;
  final String currencyName;
  final String amount;
  AccountTileModel(this.currencyCode, this.currencyName, this.amount);
}
