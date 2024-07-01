import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/get_all_todos.dart';

import 'todo_repo.mock.test.dart';

void main() {
  late MockTodoRepo repo;
  late GetAllTodosUsecase usecase;

  setUp(() {
    repo = MockTodoRepo();
    usecase = GetAllTodosUsecase(repo);
  });

  final tListOfTodos = <TodoItem>[const TodoItem.empty()];

  test('should return [GetAllTodoLists] from [TodoListRepo]', () async {
    when(() => repo.getTodos())
        .thenAnswer((_) async => Right(tListOfTodos));

    final result = await usecase();
    expect(result, equals(Right<dynamic, List<TodoItem>>(tListOfTodos)));
    verify(() => repo.getTodos()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
