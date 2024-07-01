import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';

class TodoModel extends TodoItem {
  const TodoModel({
    required super.id,
    required super.listId,
    required super.title,
    required super.isCompleted,
  });

  TodoModel.fromMap(DataMap map) : super(
    id: map['id'] as String,
    listId: map['listId'] as String,
    title: map['title'] as String,
    isCompleted: map['isCompleted'] as bool,
  );

  const TodoModel.empty()
      : this(
          id: '_empty.id',
          listId: '_empty.listId',
          title: '_empty.title',
          isCompleted: false,
        );

  TodoModel copyWith({
    String? id,
    String? listId,
    String? title,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  DataMap toMap() => {
    'id': id,
    'listId': listId,
    'title': title,
    'isCompleted': isCompleted,
  };
}
