import 'dart:collection';
import 'package:todo/items_collection.dart';

class ListWithItemCollection {
  String title;

  ListWithItemCollection({this.title});

  final ItemsCollection _itemsCollection = ItemsCollection();

  ItemsCollection get itemsCollection => _itemsCollection;
}
