import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/items_screen.dart';
import 'package:todo/screens/edit_screen.dart';
import 'package:todo/items_collection.dart';
import 'package:todo/lists_collection.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemsCollection(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListsCollection(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/itemsScreen',
        routes: {
          '/itemsScreen': (context) => ItemsScreen(),
          '/editScreen': (context) => EditScreen(),
        },
      ),
    ),
  );
}
