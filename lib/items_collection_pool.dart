import 'dart:collection';
import 'package:todo/items_collection.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todo/models/item.dart';

class ItemsCollectionPool {
  static final LocalStorage storage = LocalStorage('todo.json');
  ItemsCollection currentlySelectedCollection;
  // _lists.elementAt(storage.getItem('last_opened') ?? 0);
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
  }

  void remove(ItemsCollection itemsCollection) {
    _lists.remove(itemsCollection);
  }

  saveAllListsToStorage() {
    storage.setItem('all_lists', toJSONEncodable());
  }

  List<ItemsCollection> getAllListsFromStorage() {
    _lists.clear();
    var allLists = storage.getItem('all_lists');
    if (allLists == null) {
      print('why though');
      var col = ItemsCollection(title: 'some title', storage: storage);
      col.items = [
        Item(
          title: 'placeholder',
          isChecked: false,
        )
      ];
      _lists.add(col);
      currentlySelectedCollection = _lists[0];
    } else {
      print('this is good');
      for (var list in allLists) {
        List<Item> listItems = [];
        list['items'].map((item) {
          listItems
              .add(Item(title: item['title'], isChecked: item['isChecked']));
        }).toList();
        ItemsCollection itemList =
            ItemsCollection(title: list['title'], storage: storage);
        itemList.items = listItems;
        _lists.add(itemList);
      }
      currentlySelectedCollection = _lists[0];
    }
    print(_lists);
    return _lists;
  }

  toJSONEncodable() {
    return _lists.map((list) {
      return list.toJSONEncodable();
    }).toList();
  }
}
