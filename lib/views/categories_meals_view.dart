import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/category.dart';
import '../widgets/meal_item.dart';

class CategoriesMealsView extends StatelessWidget {
  const CategoriesMealsView({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    final categoryMeals = dummyMeals.where((meal) {
      return meal.categories.contains(category.id);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(meal: categoryMeals.elementAt(index));
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
