import 'package:bank_app/model/currency_code.dart';

class CountryFlagMap {
  static Map<CurrencyCode, String> countryFlag = {
    CurrencyCode.pln: "./web/icons/pl-flag.png",
    CurrencyCode.eur: "./web/icons/euro-flag.png",
    CurrencyCode.usd: "./web/icons/usa-flag.jpg",
    CurrencyCode.gbp: "./web/icons/uk-flag.png",
  };
}
