import 'package:flutter/material.dart';
import 'package:meal_app/provides/language_provider.dart';
import 'package:meal_app/provides/meal_provides.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter_screen';

  FiltersScreen({this.formBoardScreen = false});

  final bool formBoardScreen;

  //final  Function? saveFilter;

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue as void Function(bool?)?,
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, bool> currentFliter =
        Provider.of<MealProvide>(context, listen: true).filters;
    var len = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: len.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            widget.formBoardScreen?SliverAppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).canvasColor,
            ):
            SliverAppBar(
              title: Text(len.getTexts('filters_appBar_title') as String,),
              actions: [
                IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      Provider.of<MealProvide>(context, listen: false)
                          .setFilter();
                    })
              ],
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  len.getTexts('filters_screen_title') as String,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign:TextAlign.center,
                ),
              ),
              buildSwitchListTile(
                len.getTexts('Gluten-free').toString(),
                len.getTexts('Gluten-free-sub').toString(),
                currentFliter.cast()['gluten'],
                (newValue) {
                  setState(() {
                    currentFliter.cast()['gluten'] = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                len.getTexts('Lactose-free') as String,
                len.getTexts('Lactose-free_sub') as String,
                currentFliter.cast()['lactose'],
                (newValue) {
                  setState(() {
                    currentFliter.cast()['lactose'] = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                len.getTexts('Vegan') as String,
                len.getTexts('Vegan-sub') as String,
                currentFliter.cast()['vegan'],
                (newValue) {
                  setState(() {
                    currentFliter.cast()['vegan'] = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                len.getTexts('Vegetarian') as String,
                len.getTexts('Vegetarian-sub') as String,
                currentFliter.cast()['vegetarian'],
                (newValue) {
                  setState(() {
                    currentFliter.cast()['vegetarian'] = newValue;
                  });
                },
              ),
            SizedBox(height: 700,)
            ]))
          ],
        ),
        drawer: widget.formBoardScreen ? null : MainDrawer(),
      ),
    );
  }
}
