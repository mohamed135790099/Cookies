import 'package:flutter/material.dart';
import 'package:meal_app/provides/meal_provides.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/on_boarding_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provides/language_provider.dart';
import 'provides/theme_provider.dart';
import 'screens/category_meal_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance() ;
  final SharedPreferences prefs = await _prefs;
  final home=prefs.getBool('watched')??false;
  Widget homeScreen;
  if (home==true) {
    homeScreen = TabsScreen();
  } else {
    homeScreen = OnBoardingScreen();
  }

  runApp(MultiProvider(
    providers: [
       ChangeNotifierProvider(
          create: (_)=>MealProvide(),
      ),
      ChangeNotifierProvider(
          create: (_)=>ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_)=>LanguageProvider(),
      ),
    ],
     child: MyApp(homeScreen)
  ));
}

class MyApp extends StatefulWidget {
 final Widget homeScreen;

  MyApp(this.homeScreen);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    final accentColor=Provider.of<ThemeProvider>(context,listen:true).accentColor;
    final primary=Provider.of<ThemeProvider>(context,listen:true).primaryColor;
    final themeMode=Provider.of<ThemeProvider>(context,listen:true).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal APP',
      themeMode:themeMode,
      theme: ThemeData(
        primarySwatch: primary,
        colorScheme: ColorScheme.light().copyWith(secondary: accentColor,background:Colors.black,primary:primary),
        canvasColor: Colors.white,
        cardColor:Colors.white,
        shadowColor:Colors.amber,
        primaryColor:accentColor,
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.black),
          subtitle1: TextStyle(
            color:Colors.black,
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: primary,
        primaryColor:accentColor,
        colorScheme: ColorScheme.dark().copyWith(secondary: accentColor,background:Colors.white70,primary:primary),
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        cardColor:Color.fromRGBO(35, 34, 39, 1),
        shadowColor:Colors.white,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              subtitle1: TextStyle(
                color:Colors.white,
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (context) => widget.homeScreen,
        TabsScreen.routeName: (context) => TabsScreen(),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(),
        MealDetailScreen.RouteMeal_detail: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemeScreen.routeName:(context)=>ThemeScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
