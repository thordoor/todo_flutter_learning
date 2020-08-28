import 'package:flutter/material.dart';
import 'package:todo/screens/items_screen.dart';
import 'package:todo/screens/edit_screen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/itemsScreen',
      routes: {
        '/itemsScreen': (context) => ItemsScreen(),
        '/editScreen': (context) => EditScreen(),
      },
    ),
  );
}
