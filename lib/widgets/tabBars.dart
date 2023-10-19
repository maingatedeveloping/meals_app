import 'package:flutter/material.dart';
import '../screens/favorite_screen.dart';
import '../screens/categories_screen.dart';
import './main_drawer.dart';
import '../models/meal.dart';

class TabsWidget extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsWidget(this.favoriteMeals, {super.key});

  @override
  State<TabsWidget> createState() => _TabBarState();
}

class _TabBarState extends State<TabsWidget> {
  late List<Map<String, dynamic>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'KingsMeal',
      },
      {
        'page': FavoriteScreen(widget.favoriteMeals),
        'title': 'Favorite',
      },
      //const CategoriesScreen(),
      //const FavoriteScreen(),
    ];
    // TODO: implement initState
    super.initState();
  }

  int _slectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _slectedPageIndex = index; //the index of the tapped tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_slectedPageIndex]['title']),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: _pages[_slectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.pink,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.orange,
          //type: BottomNavigationBarType.shifting,
          currentIndex: _slectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
              ),
              label: 'Favorite',
            ),
          ]),
    );
  }
}
//void _pages List<Widget> [
  //TransactionList()
  //CatgoryItems()
//]

//int intialIndext = 0; //this work imediately we open the app 

// Void _chapgeTab {
//  SetState(int index) ) {
// _changeTab = index; 
// }
// }


//body: _pages[initialIndex],