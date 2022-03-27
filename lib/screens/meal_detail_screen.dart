import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/provides/language_provider.dart';
import 'package:meal_app/provides/meal_provides.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const RouteMeal_detail = '/meal_detail_screen';

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(color:Colors.white),
        textAlign:TextAlign.center,
      ),
    );
  }

  Widget buildContainer(Widget child, BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      height: isLandScape ? dh * 0.5 : dh * 0.25,
      width: isLandScape ? (dw * 0.5 - 30) : dw,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context){
    final mealId =  ModalRoute.of(context)?.settings.arguments as String;
    final selectMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    List<String> ingredientsLi = Provider.of<LanguageProvider>(context)
        .getTexts('ingredients-$mealId') as List<String>;
    var len = Provider.of<LanguageProvider>(context);

    var ingredients = ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).colorScheme.secondary,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                ingredientsLi[index],
              )),
        );
      },
      itemCount: ingredientsLi.length,
    );
    List<String> stepsLi = Provider.of<LanguageProvider>(context)
        .getTexts('ingredients-$mealId') as List<String>;

    var steps = ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text(
                  "# ${index + 1}",
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
              title: Text(
                stepsLi[index],
                style: TextStyle(color: Colors.black),
              ),
            ),
            Divider(),
          ],
        );
      },
      itemCount: stepsLi.length,
    );
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Directionality(
      textDirection: len.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
               expandedHeight:300,
                flexibleSpace:FlexibleSpaceBar(
                  title: Text(selectMeal.title),
                  background: Container(
                    padding: EdgeInsets.only(top: 4),
                    height: 300,
                    width: double.infinity,
                    child: InteractiveViewer(
                      child: FadeInImage(
                        placeholder:AssetImage('asset/images/a2.png'),
                        fit: BoxFit.cover,
                        image: NetworkImage(selectMeal.imageUrl,),
                      ),
                    ),
                  ),

                ),
                pinned:true,
            ),
            SliverList(delegate: SliverChildListDelegate([
              //SizedBox(height:10,),
              if (isLandScape)
                Row(
                  children: [
                    Column(
                      children: [
                        buildSectionTitle(
                            context, len.getTexts('Ingredients') as String),
                        buildContainer(ingredients, context),
                      ],
                    ),
                    Column(
                      children: [
                        buildSectionTitle(
                            context, len.getTexts('Steps') as String),
                        buildContainer(steps, context),
                      ],
                    ),
                  ],
                ),
              if (!isLandScape)
                buildSectionTitle(
                    context, len.getTexts('Ingredients') as String),
              if (!isLandScape) buildContainer(ingredients, context),
              if (!isLandScape)
                buildSectionTitle(context, len.getTexts('Steps') as String),
              if (!isLandScape) buildContainer(steps, context),
            ]))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<MealProvide>(context, listen: false)
                .toggleFavorite(mealId);
          },
          child: Icon(
            Provider.of<MealProvide>(context, listen: true)
                    .isMealFavorite(mealId)
                ? Icons.star
                : Icons.star_border,
          ),
        ),
      ),
    );
  }
}
