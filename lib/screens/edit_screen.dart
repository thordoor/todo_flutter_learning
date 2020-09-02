import 'package:flutter/material.dart';
import 'package:todo/items_collection_pool.dart';
import 'package:todo/items_collection.dart';

class EditScreen extends StatelessWidget {
  final ItemsCollection currentList = ItemsCollectionPool().current;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: SafeArea(
        child: Container(
          height: 100,
          child: Card(
            elevation: 10,
            child: Center(
              child: Text(currentList.title),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
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
                    print('edit');
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RaisedButton.icon(
                  onPressed: () {
                    print('delete');
                  },
                  icon: Icon(Icons.delete_forever),
                  label: Text('Delete'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
