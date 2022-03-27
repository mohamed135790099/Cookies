import 'package:flutter/material.dart';
import 'package:meal_app/provides/language_provider.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
/*
vip note:
Change your code to accept a VoidCallback instead of Function for the onPressed.
Btw VoidCallback is just shorthand for void Function() so you could also define
it as final void Function() onPressed;
 */
  Widget buildListTitle(String title, IconData icon, VoidCallback tapHandler,
      BuildContext context) {
    return ListTile(
      onTap: tapHandler,
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.background,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).colorScheme.background,
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var len = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: len.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Drawer(
        elevation:0,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              color: Theme.of(context).colorScheme.secondary,
              alignment: len.isEn?Alignment.centerLeft:Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Text(
                len.getTexts('drawer_name') as String,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
                // textAlign:TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTitle(len.getTexts('drawer_item1') as String, Icons.restaurant, () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            }, context),
            SizedBox(
              height: 20,
            ),
            buildListTitle(len.getTexts('drawer_item2') as String, Icons.settings, () {
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            }, context),
            SizedBox(
              height: 20,
            ),
            buildListTitle(len.getTexts('drawer_item3') as String, Icons.color_lens, () {
              Navigator.of(context).pushReplacementNamed(ThemeScreen.routeName);
            }, context),
            Divider(
              height: 10,
              color: Colors.black45,
            ),
            Container(
              alignment:len.isEn?Alignment.centerLeft:Alignment.centerRight,
              padding: EdgeInsets.only(
                  right: (len.isEn ? 0 : 20),
                  left: (len.isEn ? 20 : 0),
                  top: 20,
              ),
              child: Text(
                len.getTexts('drawer_switch_title') as String,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign:TextAlign.start,
                softWrap:false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: (len.isEn ? 0 : 20),
                left: (len.isEn ? 20 : 0),
                top: 20,
                bottom: 20,
              ),
              child: Row(
                children: [
                  Text(
                    len.getTexts('drawer_switch_item1') as String,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Switch(
                    value: Provider.of<LanguageProvider>(context,listen:true).isEn,
                    onChanged:(newValue)=>Provider.of<LanguageProvider>(context,listen:false).changeLan(newValue),
                  ),
                  Text(
                    len.getTexts('drawer_switch_item2') as String,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Divider(
                    height: 10,
                    color: Colors.black45,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
