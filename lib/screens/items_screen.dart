import 'package:flutter/material.dart';
import 'package:todo/items_collection.dart';
import 'package:provider/provider.dart';
import 'package:todo/items_collection_pool.dart';
import 'package:todo/widgets/nav_drawer.dart';

class ItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pool = context.watch<ItemsCollectionPool>();
    var currentTodoList = pool.currentlySelectedCollection;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(pool.currentlySelectedCollection.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer<ItemsCollection>(
              builder: (context, list, _) => ListView.builder(
                shrinkWrap: true,
                itemCount: currentTodoList.items.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    onChanged: (val) {
                      print(val);
                      currentTodoList.toggleIsChecked(index, val);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    value: currentTodoList.items.elementAt(index).isChecked,
                    title: Text(
                      '${currentTodoList.title} ${currentTodoList.items.elementAt(index).title}',
                    ),
                  );
                },
              ),
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
                  onPressed: () {},
                  icon: Icon(Icons.select_all),
                  label: Text('Select all'),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RaisedButton.icon(
                  onPressed: () {},
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
                            autofocus: true,
                            decoration: InputDecoration(
                                hintText: 'Enter new todo item.'),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
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
