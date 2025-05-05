import 'package:flutter/material.dart';
import 'models/settings.dart';
import 'views/settings_view.dart';
import 'views/not_found_view.dart';
import 'views/tabs_view.dart';
import 'views/categories_view.dart';
import 'views/categories_meals_view.dart';
import 'views/meal_detail_view.dart';
import 'utils/app_routes.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = dummyMeals;

  Settings settings = Settings();

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;

      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.pink,
          onPrimary: Colors.white,
          secondary: Colors.amber,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Color.fromRGBO(255, 254, 229, 1),
          onSurface: Colors.black,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 21,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          titleMedium: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      //home: CategoriesView(),
      routes: {
        AppRoutes.home: (ctx) => TabsView(),
        AppRoutes.categoriesMeals: (ctx) =>
            CategoriesMealsView(meals: _availableMeals),
        AppRoutes.mealDetail: (ctx) => MealDetailView(),
        AppRoutes.settings: (ctx) =>
            SettingsView(settings: settings, onSettingsChanged: _filterMeals),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (_) {
        return NotFoundView();
      }),
    );
  }
}
