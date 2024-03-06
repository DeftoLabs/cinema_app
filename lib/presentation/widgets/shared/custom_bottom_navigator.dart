import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigator extends StatelessWidget {

  final int currentIndex;

  const CustomBottomNavigator({
    super.key,
    required this.currentIndex,
    });

  void onItemTapped (BuildContext context, int index) {
    switch(index) {
      case 0:
      context.go('/home/0');
      break;

      case 1:
      context.go('/home/1');
      break;

      case 2:
      context.go('/home/2');
      break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      elevation: 0,
      items:const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio',
          ),

        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Category'),

        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorites'),

          
      ]);
  }
}