import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/provides/language_provider.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetailScreen.RouteMeal_detail,
      arguments: id,
    ).then((result){
      //if(result!=null)removeItem(result);
    });
  }
/*
  String get getComplexity {
    switch (complexity) {
      case Complexity.Simple:
        return "Simple";
        break;
      case Complexity.Challenging:
        return "Challenging";
        break;
      case Complexity.Hard:
        return "Hard";
        break;
      default:
        return "unknown";
        break;
    }
  }

  String get getAffordability {
    switch (affordability) {
      case Affordability.Affordable:
        return "Affordable";
        break;
      case Affordability.Pricey:
        return "Pricey";
        break;
      case Affordability.Luxurious:
        return "Luxurious";
        break;
      default:
        return "unknown";
        break;
    }
  }
  
 */

  @override
  Widget build(BuildContext context) {
    var len = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: len.isEn?TextDirection.ltr:TextDirection.rtl,
      child: InkWell(
        onTap:() {selectMeal(context);},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Hero(
                      tag:id,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          height:200,
                          width:double.infinity,
                          placeholder:AssetImage('asset/images/a2.png'),
                          fit: BoxFit.cover,
                          image: NetworkImage(imageUrl,),
                        ),
                      ),


                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                        width: 300,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        color: Colors.black54,
                        // margin:EdgeInsets.only(top:90,left:120),
                        child: Text(
                          len.getTexts('meal-$id') as String,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule,color:Theme.of(context).colorScheme.background),
                        SizedBox(
                          width: 6,
                        ),
                        Text('$duration ${len.getTexts('min')}',style:TextStyle( color:Theme.of(context).colorScheme.background),)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work,color:Theme.of(context).colorScheme.background),
                        SizedBox(
                          width: 6,
                        ),
                        Text(len.getTexts('$complexity') as String,style:TextStyle( color:Theme.of(context).colorScheme.background),)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money,color:Theme.of(context).colorScheme.background),
                        SizedBox(
                          width: 6,
                        ),
                        Text(len.getTexts('$affordability') as String,style:TextStyle( color:Theme.of(context).colorScheme.background),)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
