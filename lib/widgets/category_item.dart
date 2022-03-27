import 'package:flutter/material.dart';
import 'package:meal_app/provides/language_provider.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:provider/provider.dart';

class Category_Item extends StatelessWidget{
  final String id;
  final String title;
  final Color color;

  Category_Item({
    required this.id,
    required this.title,
    required this.color,

  });

 void selectCategory(BuildContext context){
   Navigator.of(context).pushNamed(
     CategoryMealScreen.routeName,
       arguments:{
       'id':id,
       'title':title,
      }
   );

}
  @override
  Widget build(BuildContext context) {
    var len = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection:len.isEn?TextDirection.ltr:TextDirection.rtl,
      child: InkWell(
        onTap: () {
          selectCategory(context);
        },
        splashColor:Theme.of(context).primaryColor,
        child: Container(
              padding: EdgeInsets.only(top: 40),
                child: Text(
                  len.getTexts('cat-$id') as String,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.7),
                    color,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

      ),
    );
  }
}
