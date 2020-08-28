import 'package:flutter/material.dart';
import 'package:todo/items_collection_pool.dart';
import 'package:todo/items_collection.dart';

class NavDrawer extends StatelessWidget {
  final ItemsCollectionPool store;
  final List<ItemsCollection> list;

  NavDrawer(this.store, this.list);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              child: DrawerHeader(
                child: Text(
                  'Lists',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    store.setCurrentCollection(list.elementAt(index));
                    Navigator.pop(context);
                  },
                  title: Text(
                    list.elementAt(index).title,
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
