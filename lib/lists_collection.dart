import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:todo/models/list_with_item_collection.dart';

class ListsCollection extends ChangeNotifier {
  final List<ListWithItemCollection> _lists = [
    new ListWithItemCollection(
      title: 'first list',
    ),
    new ListWithItemCollection(
      title: 'second list',
    ),
  ];

  UnmodifiableListView<ListWithItemCollection> get lists =>
      UnmodifiableListView(_lists);

  void add(ListWithItemCollection listWithItemCollection) {
    _lists.add(listWithItemCollection);
    notifyListeners();
  }

  void remove(ListWithItemCollection listWithItemCollection) {
    _lists.remove(listWithItemCollection);
    notifyListeners();
  }
}
