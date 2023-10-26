import 'package:bank_app/screen/accounts/accounts.dart';
import 'package:bank_app/screen/main/login.dart';
import 'package:bank_app/screen/main/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'screen/cards/cards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Bank app',
      theme: CupertinoThemeData(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  final String? loginToken = null;

  @override
  State<MyHomePage> createState() => _MyHomePageState(loginToken);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.loginToken);
  late String? loginToken;

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      Accounts(loginToken),
      const Cards(),
    ];
    return loginToken == null
        ? Login(
            onLogged: (loginToken) => {
                  this.loginToken = loginToken,
                  setState(() {
                    this.loginToken = loginToken;
                  })
                })
        : CupertinoPageScaffold(
            child: CupertinoTabScaffold(
              tabBuilder: (BuildContext context, index) {
                return pages[index];
              },
              tabBar: CupertinoTabBar(
                  inactiveColor: CupertinoColors.inactiveGray,
                  activeColor: CupertinoColors.white,
                  items: const [
                    BottomNavigationBarItem(
                      label: "Accounts",
                      icon: Icon(CupertinoIcons.money_dollar),
                    ),
                    BottomNavigationBarItem(
                      label: "Cards",
                      icon: Icon(CupertinoIcons.creditcard),
                    )
                  ]),
            ),
          );
  }
}
