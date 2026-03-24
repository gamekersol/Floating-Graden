import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  //runApp(const MyApp());
  runApp(
    MaterialApp(
    title: 'Flutter Demo',
    theme: themeData,
    home: const MyHomePage(),
    )
  );
}

ValueNotifier<int> currentScreenIndex = ValueNotifier(1);
List<Widget> screens = [
  InventoryScreen(),
  GardenScreen(),
  GamesScreen(),
  StoreScreen(),
];
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            controller: PageController(
              initialPage:  1,

            ),
            onPageChanged: (index) => currentScreenIndex.value = index,
            children: screens,
          ),
          InterfaceWidget(),
        ]
      ),
    );
  }
}

List<Widget> navItems = [
  NavItemWidget(iconName : 'bag.svg', index: 0,insect: 14,),
  NavItemWidget(iconName : 'home.svg', index: 1,insect: 20,),
  NavItemWidget(iconName : 'tasks.svg', index: 2,insect: 23,),
  NavItemWidget(iconName : 'store.svg', index: 3,insect: 19),
];
class NavItemWidget extends StatelessWidget{
  final String iconName;
  final int index, insect;
  const NavItemWidget({super.key,required this.iconName, required this.index, required this.insect});

  static const String _pathPrep = 'assets/images/navigation/';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentScreenIndex,
      builder: (context, value, child) {
      return AnimatedContainer( 
        duration: Duration(milliseconds: 300),
        height: 252/2.75,
        width: 252/2.75,
        decoration: BoxDecoration(
          color: index == value ? navSeclectedColor : deepGreen,
          borderRadius: BorderRadius.all(Radius.circular(34))
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.all(insect.toDouble()),
          child: SvgPicture.asset(
            _pathPrep + iconName,
            fit: BoxFit.contain,
          ),
        ),
      );
      },
    ); 
  }
}

List <Widget> currencyWidgets = [
  CurrencyWidget(value: 10, iconName: 'seed.svg',),
  CurrencyWidget(value: 10, iconName: 'coin.svg',),
  CurrencyWidget(value: 10, iconName: 'diamond.svg',),
];
class CurrencyWidget extends StatelessWidget{
  final int value;
  final String iconName;

  static const String _pathPrep = 'assets/images/trinckets/';

  const CurrencyWidget({required this.value,required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //height: 200,
        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(70),
              offset: Offset.fromDirection(1)*1.6,
              spreadRadius: 1.2,
              //blurRadius: 0.3,
            )
          ]
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 1,
            children: [
              // CUR ICON
              SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                  _pathPrep + iconName,
                  fit: BoxFit.contain,
                ),
              ),
              // CUR VALUE
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                    color: Colors.black.withAlpha(70),
                    offset: Offset.fromDirection(1)*2,
                    )
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class InterfaceWidget extends StatelessWidget {
  const InterfaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        //TOP BAR

        Align(
          alignment: Alignment.topCenter,
          child: 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 10,
                children: [
              
                  // MENU BUTTON
                  Container(
                    height: 200/3,
                    width: 200/3,
                    decoration: BoxDecoration(
                      color: deepGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(17),
                      child: SvgPicture.asset(
                        'assets/images/navigation/menu.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
              
                  // CURRENCYS
                  Expanded(
                    child: Container(
                      height: 200/3,
                      decoration: BoxDecoration(
                        color: deepGreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          spacing: 4,
                          // CUR WIDGETS
                          children: currencyWidgets
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ),

        // BOTTOM BAR
        Align(
          alignment: Alignment.bottomCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(color: deepGreen),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: navItems,
            ),
          ),
        ),
      ],
    );
  }
}


