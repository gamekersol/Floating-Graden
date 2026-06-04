import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens.dart';
import 'data/dataService.dart' as data;
import 'package:flutter_svg/flutter_svg.dart';
import 'data/currency.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'musicService.dart' as music;

Map <String, WidgetBuilder> _routes = {
  "/Tetris" : (context)=> Tetris(),
  '/' : (context) => MyHomePage(),
};
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await data.Load();
  music.Start();
  seedsIncrementor();

  runApp(
    MaterialApp(
    title: 'Flutter Demo',
    theme: themeData,
    routes: _routes,
    navigatorKey: navigatorKey,
    )
  );
}

Future<void> seedsIncrementor () async {
  while (true){
    await Future.delayed(Duration(seconds : 2));
    currencys.change(.seeds, 1);
  }
}

//TODO special panel,
//TODO fix navbar


PageController _pageController = PageController(
  initialPage:  1,
);
void GoToPage(int index) => _pageController.animateToPage(index, duration: const Duration(milliseconds: 450), curve: Curves.ease);

ValueNotifier<int> currentScreenIndex = ValueNotifier(1);
List<Widget> screens = [
  InventoryScreen(),
  GardenScreen(),
  GamesScreen(),
  StoreScreen(),
];

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Stack(
        children: [
          Positioned.fill(child: ColoredBox(color: scaffoldBgColor,)),
          PageView(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
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
        return Expanded(
          child: AnimatedContainer( 
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: index == value ? navSeclectedColor : deepGreen,
              borderRadius: BorderRadius.all(Radius.circular(34))
            ),
            child: GestureDetector(
              onTap: () => GoToPage(index),
              child: Padding(
                padding: EdgeInsetsGeometry.all(insect.toDouble() + (7 * (index == value ? 0 : 1))),
                child: SvgPicture.asset(
                  _pathPrep + iconName,
                  fit: BoxFit.contain,
                  color: index == value ? Colors.orangeAccent[200] : Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    ); 
  }
}

List <Widget> currencyWidgets = [
  CurrencyWidget(currency: currencys.values[TypeOfCurrency.seeds]!),
  CurrencyWidget(currency: currencys.values[TypeOfCurrency.coins]!),
  CurrencyWidget(currency: currencys.values[TypeOfCurrency.diamonds]!),
];
class CurrencyWidget extends StatelessWidget{
  final Currency currency;

  static const String _pathPrep = 'assets/images/trinckets/';

  const CurrencyWidget({required this.currency});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: .all(4),
        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(30),
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
              Expanded(
                flex: 7,
                child: SvgPicture.asset(
                  _pathPrep + currency.iconName,
                  fit: BoxFit.contain,
                ),
              ),
              // CUR VALUE
              Expanded(
                flex: 10,
                child: ListenableBuilder(
                  listenable: currencys,
                  builder: (_,_) => AutoSizeText(
                    currency.value.toString(),
                    textAlign: .center,
                    maxLines: 1,
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
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical:  7),
                        child: Row(
                          spacing: 8,
                          // CUR WIDGETS
                          children: currencyWidgets
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),

        // BOTTOM BAR
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
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


