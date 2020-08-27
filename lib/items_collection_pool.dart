import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:todo/items_collection.dart';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:todo/models/item.dart';

class ItemsCollectionPool extends ChangeNotifier {
  static final LocalStorage storage = LocalStorage('todo.json');
  ItemsCollection currentlySelectedCollection =
      _lists.elementAt(storage.getItem('last_opened') ?? 0);
  static final List<ItemsCollection> _lists = [];

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

  saveAllListsToStorage() {
    storage.setItem('all_lists', toJSONEncodable());
  }

  void getAllListsFromStorage() {
    var allLists = storage.getItem('all_lists');
    for (var list in allLists) {
      List<Item> listItems = [];
      list['items'].map((item) {
        listItems.add(Item(title: item['title'], isChecked: item['isChecked']));
      }).toList();
      ItemsCollection itemList =
          ItemsCollection(title: list['title'], storage: storage);
      itemList.items = listItems;
      print(itemList);
      _lists.add(itemList);
    }
    print(_lists);
  }

  toJSONEncodable() {
    return _lists.map((list) {
      return list.toJSONEncodable();
    }).toList();
  }
}
