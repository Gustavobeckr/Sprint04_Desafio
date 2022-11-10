class Filter {
  int? id;
  String? title;
  String? description;

  filterMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;

    return map;
  }
}
