
enum Complexity {
  Simple,
  Challenging,
  Hard,
}
enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}

/*
very important to known difference between @required and required

@required is just an annotation that allows analyzers let you know that you're missing a named parameter and that's it. so you can still compile the application and possibly get an exception if this named param was not passed.

However sound null-safety was added to dart,

required is now a keyword that needs to be passed to a named parameter so that it doesn't let the compiler run if this parameter has not been passed. It makes your code more strict and safe.

If you truly think this variable can be null then you would change the type by adding a ? after it so that the required keyword is not needed, or you can add a default value to the parameter

notes:
As of Dart 2.12/Flutter 2.0, you shouldn't ever need to use @required again, and should instead always use required when you have a non-nullable named parameter.
 */
