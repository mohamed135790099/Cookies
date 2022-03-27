import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/provides/language_provider.dart';
import 'package:meal_app/provides/meal_provides.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';
class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Meal> favoriteMeals=Provider.of<MealProvide>(context,listen:true).favoriteMeals;
    bool isLandScape=MediaQuery.of(context).orientation==Orientation.landscape;
    var dw=MediaQuery.of(context).size.width;
    var len=Provider.of<LanguageProvider>(context);

    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(len.getTexts('favorites_text')as String),
      );
    }
    else{
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:dw<=400?400:500,
            childAspectRatio:isLandScape?dw/(dw*0.8) :dw/(dw*0.75)
        ),
        itemBuilder: (ctx, index) {
          return MealItem(
            id:favoriteMeals[index].id,
            title:favoriteMeals[index].title,
            imageUrl:favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            complexity:favoriteMeals[index].complexity,
            affordability:favoriteMeals[index].affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
 }
