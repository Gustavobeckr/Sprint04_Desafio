class Todo {
  int? id;
  String? title;
  String? description;
  String? filter;
  String? todoDate;
  int? isFinished;

  todoMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['filter'] = filter;
    map['todoDate'] = todoDate;
    map['isFinished'] = isFinished;

    return map;
  }
}
