import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/provides/language_provider.dart';
import 'package:meal_app/provides/theme_provider.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filters_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var len = Provider.of<LanguageProvider>(context);
    final themeMode=Provider.of<ThemeProvider>(context,listen:true).tm;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage('asset/images/image.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(25),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      color: Theme.of(context).textTheme.headline1!.color,
                      width: 300,
                      child: Text(
                        len.getTexts('drawer_name') as String,
                        style: themeMode==ThemeMode.dark?Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black54):Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(25),
                      color: Theme.of(context).textTheme.headline1!.color,
                      width: 350,
                      child: Column(
                        children: [
                          Text(
                            len.getTexts('drawer_switch_title') as String,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white),
                            textAlign: TextAlign.start,
                            softWrap: false,
                          ),
                          Container(
                            color: themeMode==ThemeMode.dark? Colors.black45:Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  len.getTexts('drawer_switch_item1') as String,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Switch(
                                  value: Provider.of<LanguageProvider>(context,
                                          listen: true)
                                      .isEn,
                                  onChanged: (newValue) =>
                                      Provider.of<LanguageProvider>(context,
                                              listen: false)
                                          .changeLan(newValue),
                                ),
                                Text(
                                  len.getTexts('drawer_switch_item2') as String,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ThemeScreen(formBoardScreen:true,),
              FiltersScreen(formBoardScreen:true,),
            ],
            onPageChanged: (nextValue) {
              setState(() {
                index = nextValue;
              });
            },
          ),
          Container(
            child: Builder(
              builder: (BuildContext context) => Align(
                alignment: Alignment(0, 0.85),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: len.isEn
                          ? MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(7))
                          : MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                    ),
                    onPressed: () async {
                      Navigator.of(context)
                          .pushReplacementNamed(TabsScreen.routeName);
                      Future<SharedPreferences> _prefs =
                          SharedPreferences.getInstance();
                      final SharedPreferences prefs = await _prefs;
                      prefs.setBool('watched', true);
                    },
                    child: Text(
                      len.getTexts('start') as String,
                      style: TextStyle(
                          color:
                              useWhiteForeground(Theme.of(context).primaryColor)
                                  ? Colors.black
                                  : Colors.white,
                          fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Indicator(index),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int indicator;

  Indicator(this.indicator);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context, 0),
          buildContainer(context, 1),
          buildContainer(context, 2),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext context, int i) {
    final primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;

    return Container(
      child: indicator == i
          ? Icon(
              Icons.star,
              color: primaryColor,
            )
          : Container(
              margin: EdgeInsets.all(4),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
            ),
    );
  }
}
