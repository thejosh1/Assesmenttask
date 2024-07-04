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

  final String id;
  final String listId;
  final String title;
  final bool isCompleted;

  @override
  List<Object?> get props => [id, listId];
}
