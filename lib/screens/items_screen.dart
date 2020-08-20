import 'package:flutter/material.dart';
import 'package:todo/items_collection.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/nav_drawer.dart';

class ItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer<ItemsCollection>(
              builder: (context, list, child) => ListView.builder(
                shrinkWrap: true,
                itemCount: list.items.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    onChanged: (val) {
                      list.toggleIsChecked(index, val);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    value: list.items.elementAt(index).isChecked,
                    title: Text(
                      list.items.elementAt(index).title,
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
        onPressed: () {},
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
