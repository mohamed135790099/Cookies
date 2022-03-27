import 'package:flutter/material.dart';
import 'package:meal_app/provides/language_provider.dart';
import 'package:meal_app/provides/meal_provides.dart';
import 'package:meal_app/provides/theme_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import 'favorites_screen.dart';
import 'categories_screen.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = 'tabScreen_meal';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectPage = 0;

  void _x(int index) {
    setState(() {
      _selectPage = index;
    });
  }

  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    Provider.of<MealProvide>(context,listen:false).getDate();
    Provider.of<ThemeProvider>(context,listen:false).getThemeMode();
    Provider.of<ThemeProvider>(context,listen:false).getThemeColor();
    Provider.of<LanguageProvider>(context,listen:false).getLan();

    //List<Meal> favoriteMeals=Provider.of<MealProvide>(context,listen:false).favoriteMeals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var len=Provider.of<LanguageProvider>(context);

    _pages =[
      {
        'page': CategoriesScreen(),
        'title': len.getTexts('categories')!,
      },
      {
        'page': FavoritesScreen(),
        'title': len.getTexts('your_favorites')!,
      },
    ];
    return Directionality(
      textDirection:len.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectPage].cast()['title']),
        ),
        body: _pages[_selectPage].cast()['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _x,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
          selectedFontSize: 18,
          unselectedFontSize:15,
          currentIndex: _selectPage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category),label:len.getTexts('categories')as String,),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: len.getTexts('your_favorites')as String),
          ],
        ),
        drawer:MainDrawer(),
      ),
    );
  }
}
