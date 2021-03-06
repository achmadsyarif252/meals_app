import 'package:deli_meals_app/dummy_data.dart';
import 'package:deli_meals_app/models/meals.dart';
import 'package:deli_meals_app/screens/category_meals_screen.dart';
import 'package:deli_meals_app/screens/filrers_screen.dart';
import 'package:deli_meals_app/screens/meal_detail_screen.dart';
import 'package:deli_meals_app/screens/tab_scren.dart';
import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool>? _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters!['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters!['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters!['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        if (_filters!['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritedMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id){
    return _favoritedMeals.any((meal)=>meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deli Meals App',
      home: TabScreen(_favoritedMeals),
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetalScreen.routeName: (ctx) => MealDetalScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => TabScreen(_favoritedMeals));
      },
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
