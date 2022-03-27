import 'package:flutter/material.dart';
import 'package:meal_app/provides/meal_provides.dart';
import 'package:meal_app/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
          padding: EdgeInsets.all(25),
          children: Provider.of<MealProvide>(context)
              .availableCategory
              .map(
                (cateDate) => Category_Item(
                  id: cateDate.id,
                  title: cateDate.title,
                  color: cateDate.color,
                ),
              )
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //مندوب الشبكة: مندوب SliverGrid مع أقصى مدى للمحور المتقاطع
            maxCrossAxisExtent: 200,
            // this mean % width will be 200
            childAspectRatio: 3 / 2,
            // this mean % width to height
            crossAxisSpacing: 20,
            //The distance it will take from the elements and some from the sides
            mainAxisSpacing:
                20, //The distance you take from the elements and some from the verticality
          )),
    );
  }
}
