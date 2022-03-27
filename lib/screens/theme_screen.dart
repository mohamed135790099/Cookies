import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/provides/language_provider.dart';
import 'package:meal_app/provides/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  static const String routeName = 'theme_screen';
  ThemeScreen({this.formBoardScreen=false});
  final bool formBoardScreen;


  Widget radioButtonList(
      ThemeMode themeValue, Text txt, IconData icon, BuildContext context) {
    return RadioListTile(
      value: themeValue,
      title: txt,
      secondary: Icon(
        icon,
        color: Theme.of(context).colorScheme.background,
      ),
      groupValue: Provider.of<ThemeProvider>(context, listen: true).tm,
      onChanged: (newValue) =>
          Provider.of<ThemeProvider>(context, listen: false)
              .changeThemeMode(themeValue),
    );
  }

  ListTile listBuild(BuildContext context, String txt) {
    final primaryColor = Provider.of<ThemeProvider>(context,listen:true).primaryColor;
    final accentColor = Provider.of<ThemeProvider>(context,listen:true).accentColor;
    var len=Provider.of<LanguageProvider>(context);

    return ListTile(
      title: Text(len.getTexts(txt) as String,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      trailing: CircleAvatar(
        backgroundColor: txt == "primary" ? primaryColor : accentColor,
      ),
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
          elevation: 4,
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: txt == "primary"
                  ? Provider.of<ThemeProvider>(ctx, listen: true)
                      .primaryColor
                  : Provider.of<ThemeProvider>(ctx, listen: true)
                      .accentColor,
              onColorChanged: (newValue) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .onChange(newValue, txt == "primary" ?1 : 2),
              colorPickerWidth: 300,
              pickerAreaHeightPercent: 0.7,
              displayThumbColor: true,
              enableAlpha: false,
              showLabel: false,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var len=Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection:len.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar:formBoardScreen?AppBar(elevation:0,backgroundColor:Theme.of(context).canvasColor,):AppBar(title: Text(len.getTexts('theme_appBar_title') as String),),
        body: Column(
          children: [
            Container(
              child: Text(len.getTexts('theme_screen_title')as String,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              padding: EdgeInsets.all(20),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      len.getTexts('theme_mode_title')as String,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  radioButtonList(
                      ThemeMode.system,
                      Text(
                        len.getTexts('System_default_theme')as String,
                        style: TextStyle(fontSize: 16),
                      ),
                      Icons.align_vertical_bottom,
                      context),
                  radioButtonList(
                      ThemeMode.light,
                      Text(len.getTexts('light_theme')as String, style: TextStyle(fontSize: 16)),
                      Icons.wb_sunny_outlined,
                      context),
                  radioButtonList(
                      ThemeMode.dark,
                      Text(len.getTexts('dark_theme')as String, style: TextStyle(fontSize: 16)),
                      Icons.nightlight_round,
                      context),
                  listBuild(context, "primary"),
                  listBuild(context, "accent")
                ],
              ),
            )
          ],
        ),
        drawer:formBoardScreen?null:MainDrawer(),
      ),
    );
  }
}
