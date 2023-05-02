import '../model/account_tile_model.dart';
import '../model/currency_code.dart';

List<AccountTileModel> getAllAccounts() {
  return [
    AccountTileModel(CurrencyCode.pln, "Polski zloty", "269"),
    AccountTileModel(CurrencyCode.gbp, "Great Britain Pound", "420"),
    AccountTileModel(CurrencyCode.usd, "United States Dollar", "0"),
    AccountTileModel(CurrencyCode.eur, "Euro", "0")
  ];
}

List<AccountTileModel> getUserAccounts() {
  return [
    AccountTileModel(CurrencyCode.pln, "Polski zloty", "269"),
    AccountTileModel(CurrencyCode.gbp, "Great Britain Pound", "420")
  ];
}
