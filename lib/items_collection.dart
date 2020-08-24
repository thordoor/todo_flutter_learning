import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:todo/models/item.dart';

class ItemsCollection extends ChangeNotifier {
  final String title;
  final List<Item> _items = [
    new Item(title: 'an item', isChecked: false),
    new Item(title: 'another item', isChecked: false),
  ];

  ItemsCollection({this.title});

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  void toggleIsChecked(int index, bool newValue) {
    _items.elementAt(index).isChecked = newValue;
    notifyListeners();
  }

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}
