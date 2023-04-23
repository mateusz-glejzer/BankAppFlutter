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

class _AccountPanelState extends State<AccountPanel> with TickerProviderStateMixin {
  AccountPanelViewModel _accountPanelViewModel;
  _AccountPanelState(this._accountPanelViewModel);
  String _defaultFlag = "bank_app/web/icons/money-sack.png";
  late AnimationController _controller;

  @override
  void initState()
  {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
  }
  bool isAccountListOpen = false;

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
                  _defaultFlag)),
          GestureDetector(onTap: (){
            if (isAccountListOpen) {
            _controller.reverse();
            } else {
              _controller.forward();
            }
            isAccountListOpen = !isAccountListOpen;
            
          },child: RotationTransition(
        turns: Tween(begin: 0.0, end: isAccountListOpen ? 0.5 : 0.0).animate(_controller),
        child: Icon(Icons.keyboard_arrow_up),))
        ],
      ),
      Row(children: [
        ElevatedButton(onPressed: () {}, child: Text("Add Money")),
        ElevatedButton(
          onPressed: () {},
          child: Text("Exchange"),
        ),
      ]),
    ]);
  }
}
