import 'package:bank_app/model/countryFlagMap.dart';
import 'package:flutter/cupertino.dart';
import '../../model/accountTileModel.dart';

class AccountPanel extends StatefulWidget {
  final AccountTileModel _accountPanelViewModel;
  final void Function() onGectureDetectorClicked;
  const AccountPanel(this._accountPanelViewModel, this.onGectureDetectorClicked, {super.key});
  @override
  State<StatefulWidget> createState() =>
      _AccountPanelState(_accountPanelViewModel, onGectureDetectorClicked);
}

class _AccountPanelState extends State<AccountPanel>
    with TickerProviderStateMixin {
  final AccountTileModel _accountPanelViewModel;
  final void Function() onGectureDetectorClicked;

  _AccountPanelState(
      this._accountPanelViewModel, this.onGectureDetectorClicked);

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  }

  bool isAccountListOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(_accountPanelViewModel.amount),
                  Text(_accountPanelViewModel.currencyName)
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (isAccountListOpen) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                  onGectureDetectorClicked();
                  setState(() {
                    isAccountListOpen = !isAccountListOpen;
                  });
                },
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: isAccountListOpen ? 0.5 : 0.0)
                      .animate(_controller),
                  child: const Icon(
                    CupertinoIcons.arrow_down,
                    color: CupertinoColors.black,
                  ),
                ),
              ),
            ],
          ),
          Image(
            width: 60.0,
            height: 60.0,
            image: AssetImage(CountryFlagMap
                    .countryFlag[_accountPanelViewModel.currencyCode]!),
          ),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CupertinoButton(
          onPressed: () {},
          color: CupertinoColors.black,
          child:
              const Text("Add Money", style: TextStyle(color: CupertinoColors.white)),
        ),
        CupertinoButton(
          onPressed: () {},
          color: CupertinoColors.black,
          child:
              const Text("Exchange", style: TextStyle(color: CupertinoColors.white)),
        ),
      ]),
    ]);
  }
}
