import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:todo/models/item.dart';
import 'package:localstorage/localstorage.dart';

class ItemsCollection extends ChangeNotifier {
  final String title;
  final LocalStorage storage;
  final List<Item> _items = [
    new Item(title: 'an item', isChecked: false),
    new Item(title: 'another item', isChecked: false),
  ];

  ItemsCollection({this.title, this.storage});

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  void toggleIsChecked(int index, bool newValue) {
    _items.elementAt(index).isChecked = newValue;
    storage.setItem('todoList_$title', toJSONEncodable());
    notifyListeners();
  }

  void add(Item item) {
    _items.add(item);
    storage.setItem('todoList_$title', toJSONEncodable());
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    storage.setItem('todoList_$title', toJSONEncodable());
    notifyListeners();
  }

  toJSONEncodable() {
    return _items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
