import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'data/currency.dart';
import 'package:audioplayers/audioplayers.dart';

Map <String, WidgetBuilder> _routes = {
  "/Tetris" : (context)=> Tetris(),
  '/' : (context) => MyHomePage(),
};

void main() {
  runApp(
    MaterialApp(
    title: 'Flutter Demo',
    theme: themeData,
    routes: _routes,
    )
  );
}

PageController pageController = PageController(
  initialPage:  1,
);
ValueNotifier<int> currentScreenIndex = ValueNotifier(1);
List<Widget> screens = [
  InventoryScreen(),
  GardenScreen(),
  GamesScreen(),
  StoreScreen(),
];
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    // MUSIC?
    musicTime();

    return Scaffold(
      body: Stack(
        children: [
          Container(color: scaffoldBgColor,),
          PageView(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            onPageChanged: (index) => currentScreenIndex.value = index,
            children: screens,
          ),
          InterfaceWidget(),
        ]
      ),
    );
  }
  void musicTime (){
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    if(audioPlayer.state != PlayerState.playing)audioPlayer.play(AssetSource('audio/Stand-Tall.mp3'));
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
          child: GestureDetector(
            onTap: () => pageController.animateToPage(index, duration: const Duration(milliseconds: 450), curve: Curves.ease),
            child: Padding(
              padding: EdgeInsetsGeometry.all(insect.toDouble()),
              child: SvgPicture.asset(
                _pathPrep + iconName,
                fit: BoxFit.contain,
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
                  _pathPrep + currency.iconName,
                  fit: BoxFit.contain,
                ),
              ),
              // CUR VALUE
              ListenableBuilder(
                listenable: currencys,
                builder: (_,_) => Text(
                  currency.value.toString(),
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
                  ),
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


