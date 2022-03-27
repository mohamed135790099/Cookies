import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';


class MealProvide extends ChangeNotifier {


  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  List<String> prefsMealId = [];
  List<Category> availableCategory = [];

  void toggleFavorite(String mealId) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }
    prefs.setStringList('prefsMealId', prefsMealId);

    notifyListeners();
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  void setFilter() async {
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters.cast()['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (filters.cast()['lactose'] && !meal.isLactoseFree) {
        return false;
      }

      if (filters.cast()['vegan'] && !meal.isVegan) {
        return false;
      }

      if (filters.cast()['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.setBool('gluten', filters.cast()['gluten']);
    prefs.setBool('lactose', filters.cast()['lactose']);
    prefs.setBool('vegan', filters.cast()['vegan']);
    prefs.setBool('vegetarian', filters.cast()['vegetarian']);

    notifyListeners();
  }

  void getDate() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefsMealId = prefs.getStringList('prefsMealId') ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);

      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
      notifyListeners();
    }

    filters.cast()['gluten'] = prefs.getBool('gluten') ?? false;
    filters.cast()['lactose'] = prefs.getBool('lactose') ?? false;
    filters.cast()['vegan'] = prefs.getBool('vegan') ?? false;
    filters.cast()['vegetarian'] = prefs.getBool('vegetarian') ?? false;

    List<Meal> fm = [];
    favoriteMeals.forEach((faMeal) {
      availableMeals.forEach((avMeal) {
        if(faMeal==avMeal) fm.add(faMeal);
      });
    });
    favoriteMeals=fm;


    List<Category> ac = [];
    availableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if (cat.id == catId) {
            if (!ac.any((cat) => cat.id == catId)) {
              ac.add(cat);
            }
          }
        });
      });
    });
    availableCategory = ac;

    notifyListeners();
  }
}
