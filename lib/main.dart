import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meals_app/dummy.data.dart';
import 'screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './widgets/tabBars.dart';
import './screens/filters_screen.dart';
import './models/meal.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  final List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((element) => element.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        //canvasColor: const Color.fromARGB(255, 12, 1, 105),
        canvasColor: Colors.orange,
        fontFamily: 'Raleway',
        textTheme: ThemeData().textTheme.copyWith(
              bodyMedium: const TextStyle(
                color: Colors.white,
              ),
              titleSmall: const TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                color: Colors.white,
              ),
            ),
      ),
      //home: const CategorysScreen(),
      routes: {
        '/': (context) => TabsWidget(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
              _availableMeals,
            ),
        MealDetail.routeName: (context) =>
            MealDetail(_toggleFavorite, _isMealFavorite),
        Filters.routeName: (context) => Filters(_setFilters, _filters),
      },
/*       onGenerateRoute: (settings) {
        if (setting.name == '/meal_deatail') {
          return ...;
        } else if(setting.name == '/something_else') {
          return ...;
        }
          return MaterialPageRoute(
            builder: (context) => const CategoriesScreen(),
          );
      }, */
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => const CategoriesScreen());
      },
    );
  }
}
