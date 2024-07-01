import 'package:equatable/equatable.dart';

class TodoItem extends Equatable {
  const TodoItem({
    required this.id,
    required this.listId,
    required this.title,
    required this.isCompleted,
  });

  const TodoItem.empty()
      : this(id: '', listId: '', title: '', isCompleted: false);

  // TodoItem copyWith({
  //   String? id,
  //   String? listId,
  //   String? title,
  //   bool? isCompleted,
  // }) {
  //   return TodoItem(
  //     id: id ?? this.id,
  //     listId: listId ?? this.listId,
  //     title: title ?? this.title,
  //     isCompleted: isCompleted ?? this.isCompleted,
  //   );
  // }

  final String id;
  final String listId;
  final String title;
  final bool isCompleted;

  @override
  List<Object?> get props => [id, listId];
}
