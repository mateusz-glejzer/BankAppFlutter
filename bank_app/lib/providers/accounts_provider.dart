import 'package:bank_app/providers/transaction_provider.dart';

import '../model/account_tile_model.dart';
import '../model/currency_code.dart';

var allAccounts = [
  AccountTileModel(CurrencyCode.pln, "Polski zloty", "269"),
  AccountTileModel(CurrencyCode.gbp, "Great Britain Pound", "420"),
  AccountTileModel(CurrencyCode.usd, "United States Dollar", "0"),
  AccountTileModel(CurrencyCode.eur, "Euro", "0")
];
var accountMap = {
  CurrencyCode.pln: AccountTileModel(CurrencyCode.pln, "Polski zloty", "0"),
  CurrencyCode.gbp:
      AccountTileModel(CurrencyCode.gbp, "Great Britain Pound", "0"),
  CurrencyCode.usd:
      AccountTileModel(CurrencyCode.usd, "United States Dollar", "0"),
  CurrencyCode.eur: AccountTileModel(CurrencyCode.eur, "Euro", "0"),
};

Future<AccountTileModel> getAccount(CurrencyCode code) async {
  var account = accountMap[code]!;
  var balance = await getAccountBalance(code);
  account.amount = balance.toString();
  return account;
}

List<AccountTileModel> getAllAccounts() {
  return allAccounts;
}

Future<List<AccountTileModel>> getUserAccounts() async {
  for(var acc in allAccounts)
  {
    acc.amount = await getAccountBalance(acc.currencyCode);
  }
  return allAccounts;
}

Future<String> getAccountBalance(CurrencyCode currencyCode) async {
  var transactions = await getTransations(currencyCode);
  var balance = 0;
  for (var transaction in transactions) {
    balance += int.parse(transaction.sum);
  }
  return balance.toString();
}
