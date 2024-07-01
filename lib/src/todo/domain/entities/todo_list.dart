import 'package:equatable/equatable.dart';

class TodoList extends Equatable {
  const TodoList({
    required this.id,
    required this.title,
  });

  const TodoList.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
        );

  final String id;
  final String title;

  @override
  List<Object?> get props => [id, title,];
}
