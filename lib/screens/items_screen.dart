import 'package:flutter/material.dart';
import 'package:todo/items_collection.dart';
import 'package:todo/models/item.dart';
import 'package:todo/items_collection_pool.dart';
import 'package:todo/widgets/nav_drawer.dart';

class ItemsScreen extends StatefulWidget {
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  String newItemValue = '';
  String selectText = 'Select all';
  List<ItemsCollection> lists;
  ItemsCollectionPool store = ItemsCollectionPool();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeLists();
  }

  void _initializeLists() {
    lists = store.getAllListsFromStorage();
  }

  void updateStateCb() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ItemsCollection currentTodoList = store.current;
    return Scaffold(
      drawer: NavDrawer(store, lists, updateStateCb),
      appBar: AppBar(
        title: Text(currentTodoList.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: currentTodoList.items.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  onChanged: (val) {
                    setState(() {
                      currentTodoList.toggleIsChecked(index, val);
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  value: currentTodoList.items.elementAt(index).isChecked,
                  title: Text(
                    '${currentTodoList.items.elementAt(index).title}',
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: RaisedButton.icon(
                  onPressed: () {
                    List checkedItems = [];
                    for (Item item in currentTodoList.items) {
                      if (item.isChecked == true) {
                        checkedItems.add(item);
                      }
                    }
                    if (checkedItems.length == currentTodoList.items.length) {
                      for (Item item in currentTodoList.items) {
                        item.isChecked = false;
                        selectText = 'Select all';
                      }
                    } else {
                      for (Item item in currentTodoList.items) {
                        item.isChecked = true;
                        selectText = 'Deselect all';
                      }
                    }
                    setState(() {});
                  },
                  icon: Icon(Icons.select_all),
                  label: Text(selectText),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RaisedButton.icon(
                  onPressed: () {
                    store.copyList();
                  },
                  icon: Icon(Icons.content_copy),
                  label: Text('copy list'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                newItemValue = value;
                              });
                            },
                            autofocus: true,
                            decoration: InputDecoration(
                                hintText: 'Enter new todo item.'),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            currentTodoList.add(
                              Item(
                                title: newItemValue,
                                isChecked: false,
                              ),
                            );
                            store.saveAllListsToStorage();
                            store.getAllListsFromStorage();
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Text('Save!'),
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
