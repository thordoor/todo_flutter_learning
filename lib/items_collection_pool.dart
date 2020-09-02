import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:todo/items_collection.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todo/models/item.dart';

class ItemsCollectionPool {
  static final ItemsCollectionPool _itemsCollectionPool =
      ItemsCollectionPool._internal();
  factory ItemsCollectionPool() {
    return _itemsCollectionPool;
  }
  ItemsCollectionPool._internal();

  static final LocalStorage storage = LocalStorage('todo.json');

  ItemsCollection currentlySelectedCollection;
  final List<ItemsCollection> _lists = [];

  get current => currentlySelectedCollection;

  UnmodifiableListView<ItemsCollection> get lists =>
      UnmodifiableListView(_lists);

  void setCurrentCollection(ItemsCollection itemsCollection) {
    currentlySelectedCollection = itemsCollection;
    storage.setItem('last_opened', _lists.indexOf(itemsCollection));
  }

  void add(ItemsCollection itemsCollection) {
    _lists.add(itemsCollection);
    storage.setItem('todo_list', itemsCollection.toJSONEncodable());
    saveAllListsToStorage();
  }

  void remove(ItemsCollection itemsCollection) {
    _lists.remove(itemsCollection);
    storage.setItem('todo_list', itemsCollection.toJSONEncodable());
    saveAllListsToStorage();
  }

  saveAllListsToStorage() {
    storage.setItem('all_lists', toJSONEncodable());
  }

  Future getAllListsFromStorage() async {
    _lists.clear();
    return storage.ready.then((result) {
      if (result == true) {
        var allLists = storage.getItem('all_lists');
        if (allLists != null) {
          for (var list in allLists) {
            List<Item> listItems = [];
            list['items'].map((item) {
              listItems.add(
                  Item(title: item['title'], isChecked: item['isChecked']));
            }).toList();
            ItemsCollection itemList =
                ItemsCollection(title: list['title'], storage: storage);
            itemList.items = listItems;
            add(itemList);
          }
          if (current != null) {
            currentlySelectedCollection = current;
          } else {
            try {
              currentlySelectedCollection =
                  _lists[storage.getItem('last_opened')];
            } catch (e) {
              currentlySelectedCollection = _lists[0];
            }
          }
        } else {
          ItemsCollection col =
              ItemsCollection(title: 'My first list', storage: storage);
          col.items = [
            Item(
              title: 'My first item',
              isChecked: false,
            )
          ];
          add(col);
          currentlySelectedCollection = _lists[0];
        }
      }
    });
  }

  copyList() {
    String newListTitle = '${currentlySelectedCollection.title}(copy)';
    List<Item> listItems = [];
    currentlySelectedCollection.items.map((item) {
      listItems.add(
        Item(
          title: item.title,
          isChecked: false,
        ),
      );
    }).toList();
    ItemsCollection copiedCollection =
        ItemsCollection(title: newListTitle, storage: storage);
    copiedCollection.items = listItems;
    add(copiedCollection);
    saveAllListsToStorage();
  }

  toJSONEncodable() {
    return _lists.map((list) {
      return list.toJSONEncodable();
    }).toList();
  }
}
