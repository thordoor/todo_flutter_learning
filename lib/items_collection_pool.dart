import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:todo/items_collection.dart';

class ItemsCollectionPool extends ChangeNotifier {
  ItemsCollection currentlySelectedCollection = _lists.elementAt(0);
  static final List<ItemsCollection> _lists = [
    new ItemsCollection(
      title: 'first list',
    ),
    new ItemsCollection(
      title: 'second list',
    ),
  ];

  UnmodifiableListView<ItemsCollection> get lists =>
      UnmodifiableListView(_lists);

  void setCurrentCollection(ItemsCollection itemsCollection) {
    currentlySelectedCollection = itemsCollection;
    notifyListeners();
  }

  void add(ItemsCollection itemsCollection) {
    _lists.add(itemsCollection);
    notifyListeners();
  }

  void remove(ItemsCollection itemsCollection) {
    _lists.remove(itemsCollection);
    notifyListeners();
  }
}
