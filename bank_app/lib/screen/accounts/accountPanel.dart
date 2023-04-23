import 'package:bank_app/model/countryFlagMap.dart';
import 'package:flutter/material.dart';

import '../../model/accountPanelViewModel.dart';

class AccountPanel extends StatefulWidget {
  AccountPanelViewModel _accountPanelViewModel;
  AccountPanel(this._accountPanelViewModel);
  @override
  State<StatefulWidget> createState() =>
      _AccountPanelState(_accountPanelViewModel);
}

class _AccountPanelState extends State<AccountPanel> {
  AccountPanelViewModel _accountPanelViewModel;
  _AccountPanelState(this._accountPanelViewModel);
  String _defaultFlag = "bank_app/web/icons/money-sack.png";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Column(
            children: [
              Text(_accountPanelViewModel.amount),
              Text(_accountPanelViewModel.currencyName)
            ],
          ),
          CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage(CountryFlagMap
                      .countryFlag[_accountPanelViewModel.currencyCode] ??
                  _defaultFlag))
        ],
      ),
      Row(
        children: [
        ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [Text("Add Money"), Icon(Icons.add)],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [Text("Exchange"), Icon(Icons.currency_exchange)],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Icon(Icons.menu),
        )
      ]),
    ]);
  }
}
