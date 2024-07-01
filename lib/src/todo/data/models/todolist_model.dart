import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';

class TodoListModel extends TodoList {
  TodoListModel({required super.id, required super.title});

  TodoListModel.empty()
      : this(
          id: '',
          title: '_empty.title',
        );

  TodoListModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          title: map['title'] as String,
  );

  TodoListModel copyWith({
    String? id,
    String? title,
  }) {
    return TodoListModel(
      id: id ?? super.id,
      title: title ?? super.title,
    );
  }

  DataMap toMap() => {
        'id': id,
        'title': title,
      };
}
