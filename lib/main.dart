import 'package:flutter/material.dart';
import 'views/categories_view.dart';
import 'views/categories_meals_view.dart';
import 'utils/app_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        AppRoutes.home: (ctx) => CategoriesView(),
        AppRoutes.categoriesMeals: (ctx) => CategoriesMealsView(),
      },
    );
  }
}
