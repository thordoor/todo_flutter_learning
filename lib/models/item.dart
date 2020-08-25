class Item {
  String title;
  bool isChecked;

  Item({this.title, this.isChecked});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['title'] = title;
    m['isChecked'] = isChecked;

    return m;
  }
}
