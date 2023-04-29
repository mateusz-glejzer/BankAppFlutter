import 'package:bank_app/model/account_tile_model.dart';
import 'package:flutter/cupertino.dart';

import '../../model/country_flag_map.dart';

class AccountTile extends StatefulWidget {
  final AccountTileModel model;

  const AccountTile(this.model, {super.key});
  @override
  State<StatefulWidget> createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  @override
  Widget build(BuildContext context) {
    final AccountTileModel model = widget.model;
    return CupertinoListTile(
      leading: Image(
          image: AssetImage(CountryFlagMap.countryFlag[model.currencyCode]!)),
      title: Text(model.currencyName),
      additionalInfo: Text(model.amount),
    );
  }
}
