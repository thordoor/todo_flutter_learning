import 'dart:collection';
import 'package:todo/models/item.dart';
import 'package:localstorage/localstorage.dart';

class ItemsCollection {
  final String title;
  final LocalStorage storage;
  final List<Item> _items = [];

  ItemsCollection({this.title, this.storage});

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  set items(List<Item> items) {
    for (var item in items) {
      _items.add(item);
    }
  }

  @override
  String toString() {
    String result = "$title $storage $items";
    return result;
  }

  void toggleIsChecked(int index, bool newValue) {
    _items.elementAt(index).isChecked = newValue;
    storage.setItem('todoList_$title', toJSONEncodable());
  }

  void add(Item item) {
    _items.add(item);
    storage.setItem('todoList_$title', toJSONEncodable());
  }

  void remove(Item item) {
    _items.remove(item);
    storage.setItem('todoList_$title', toJSONEncodable());
  }

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();
    m['title'] = title;
    m['items'] = [];
    _items.map((item) {
      m['items'].add(item.toJSONEncodable());
    }).toList();
    return m;
  }
}
