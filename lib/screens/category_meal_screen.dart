import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/provides/meal_provides.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealScreen extends StatefulWidget {
  static const String routeName = 'category_meal';

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {

  late String categoryTitle;
  late List<Meal>categoryMeals;
 @override
 void didChangeDependencies(){
   final List<Meal> availableMeals= Provider.of<MealProvide>(context,listen:false).availableMeals;
   final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
   final categoryId = routeArg.cast()['id'];
   categoryTitle = routeArg.cast()['title'];
   categoryMeals = availableMeals.where((meal) {
     return meal.categories.contains(categoryId);
   }).toList();

   super.didChangeDependencies();
  }
  /*
*  void _removeMeal(String mealId) {
 setState(() {
 categoryMeals.removeWhere((meal) =>
     meal.id==mealId,
 );
 });
  }
 */
  @override
  Widget build(BuildContext context) {
   bool isLandScape=MediaQuery.of(context).orientation==Orientation.landscape;
   var dw=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryTitle'),
      ),
      body: GridView.builder(
      itemBuilder: (ctx, index) {
          return MealItem(
            id:categoryMeals[index].id,
            title:categoryMeals[index].title,
            imageUrl:categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity:categoryMeals[index].complexity,
            affordability:categoryMeals[index].affordability,
          );
        },
        itemCount: categoryMeals.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:dw<=400?400:500,
            childAspectRatio:isLandScape?dw/(dw*0.85) :dw/(dw*0.75)
        ),
    ),
    );
  }


}
