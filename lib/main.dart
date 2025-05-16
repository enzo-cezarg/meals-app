import 'package:flutter/material.dart';
import 'models/settings.dart';
import 'views/settings_view.dart';
import 'views/not_found_view.dart';
import 'views/tabs_view.dart';
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
  List<Meal> _favoriteMeals = [];

  Settings settings = Settings();

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

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

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
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
          primary: Color.fromARGB(255, 239, 35, 60),
          onPrimary: Color.fromARGB(255, 237, 242, 244),
          secondary: Color.fromARGB(255, 237, 242, 244),
          onSecondary: Color.fromARGB(255, 237, 242, 244),
          error: Color.fromARGB(255, 217, 4, 41),
          onError: Color.fromARGB(255, 237, 242, 244),
          surface: Color.fromARGB(255, 237, 242, 244),
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
        AppRoutes.home: (ctx) => TabsView(favoriteMeals: _favoriteMeals),
        AppRoutes.categoriesMeals: (ctx) =>
            CategoriesMealsView(meals: _availableMeals),
        AppRoutes.mealDetail: (ctx) =>
            MealDetailView(isFavorite: _isFavorite, onToggleFavorite: _toggleFavorite),
        AppRoutes.settings: (ctx) =>
            SettingsView(settings: settings, onSettingsChanged: _filterMeals),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (_) {
        return NotFoundView();
      }),
    );
  }
}
