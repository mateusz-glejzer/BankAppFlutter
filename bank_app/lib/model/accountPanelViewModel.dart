import 'package:bank_app/model/currencyCode.dart';

class AccountPanelViewModel {
  final CurrencyCode currencyCode;
  final String currencyName;
  final String amount;
  AccountPanelViewModel(this.currencyCode, this.currencyName, this.amount);
}
