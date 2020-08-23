import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/items_collection_pool.dart';

class NavDrawer extends StatelessWidget {
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
            Consumer<ItemsCollectionPool>(
              builder: (context, pool, child) => ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: pool.lists.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      pool.setCurrentCollection(pool.lists.elementAt(index));
                      Navigator.pop(context);
                    },
                    title: Text(
                      pool.lists.elementAt(index).title,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
