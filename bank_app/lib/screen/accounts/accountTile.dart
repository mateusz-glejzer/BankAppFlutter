import 'package:bank_app/model/accountTileModel.dart';
import 'package:flutter/cupertino.dart';

import '../../model/countryFlagMap.dart';

class AccountTile extends StatefulWidget {
  final AccountTileModel model;

  const AccountTile(this.model, {super.key});
  @override
  State<StatefulWidget> createState() => _AccountTileState(model);
}

class _AccountTileState extends State<AccountTile> {
  final AccountTileModel model;
  _AccountTileState(this.model);
  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leading: Image(
          image: AssetImage(CountryFlagMap.countryFlag[model.currencyCode]!)),
      title: Text(model.currencyName),
      additionalInfo: Text(model.amount),
    );
  }
}
