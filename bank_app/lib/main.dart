import 'package:bank_app/screen/accounts/accounts.dart';
import 'package:flutter/cupertino.dart';
import 'screen/cards/cards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Bank app',
      theme: CupertinoThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List pages = [
    Accounts(),
    Cards(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
