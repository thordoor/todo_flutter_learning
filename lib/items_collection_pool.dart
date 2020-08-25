import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:todo/items_collection.dart';
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';

class ItemsCollectionPool extends ChangeNotifier {
  static final LocalStorage storage = LocalStorage('todo.json');
  ItemsCollection currentlySelectedCollection =
      _lists.elementAt(storage.getItem('last_opened') ?? 0);
  static final List<ItemsCollection> _lists = [
    new ItemsCollection(
      title: 'first list',
      storage: storage,
    ),
    new ItemsCollection(
      title: 'second list',
      storage: storage,
    ),
  ];

  UnmodifiableListView<ItemsCollection> get lists =>
      UnmodifiableListView(_lists);

  void setCurrentCollection(ItemsCollection itemsCollection) {
    currentlySelectedCollection = itemsCollection;
    storage.setItem('last_opened', _lists.indexOf(itemsCollection));
    notifyListeners();
  }

  void add(ItemsCollection itemsCollection) {
    _lists.add(itemsCollection);
    storage.setItem('todo_list', itemsCollection.toJSONEncodable());
    notifyListeners();
  }

  void remove(ItemsCollection itemsCollection) {
    _lists.remove(itemsCollection);
    notifyListeners();
  }
}
