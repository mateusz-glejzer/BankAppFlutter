import 'package:bank_app/model/currencyCode.dart';

class CountryFlagMap {
  static Map<CurrencyCode, String> countryFlag = {
    CurrencyCode.PL: "./web/icons/pl-flag.png",
    CurrencyCode.EUR: "./web/icons/euro-flag.png",
    CurrencyCode.USD: "./web/icons/usa-flag.jpg",
    CurrencyCode.GBP: "./web/icons/uk-flag.png",
  };
}
