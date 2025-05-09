import 'package:flutter/material.dart';
import 'categories_view.dart';
import 'favorite_view.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsView extends StatefulWidget {
  const TabsView({required this.favoriteMeals, super.key});

  final List<Meal> favoriteMeals;

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  int _selectedViewIndex = 0;
  List<Map<String, Object>>? _views;

  @override
  void initState() {
    super.initState();
    _views = [
      {
        'title': 'Lista de Categorias',
        'view': CategoriesView(),
      },
      {
        'title': 'Meus Favoritos',
        'view': FavoriteView(favoriteMeals: widget.favoriteMeals)
      },
    ];
  }

  _selectView(int index) {
    setState(() {
      _selectedViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _views![_selectedViewIndex]['title'] as String,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: MainDrawer(),
      body: _views![_selectedViewIndex]['view'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectView,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.black45,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        currentIndex: _selectedViewIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
