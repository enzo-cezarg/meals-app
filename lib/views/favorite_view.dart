import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({required this.favoriteMeals, super.key});

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          'Nenhuma Refeição Favorita!',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(meal: favoriteMeals.elementAt(index));
        },
      );
    }
  }
}
