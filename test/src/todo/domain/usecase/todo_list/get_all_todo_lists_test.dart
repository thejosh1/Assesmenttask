import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_list/get_all_todo_lists.dart';

import 'todo_list_repo.mock.test.dart';

void main() {
  late MockTodoListRepo repo;
  late GetAllTodoListsUsecase usecase;

  setUp(() {
    repo = MockTodoListRepo();
    usecase = GetAllTodoListsUsecase(repo);
  });

  final tListTodos = <TodoList>[const TodoList.empty()];

  test('should return [GetAllTodoLists] from [TodoListRepo]', () async {
    when(() => repo.getAllTodoLists())
        .thenAnswer((_) async => Right(tListTodos));

    final result = await usecase();
    expect(result, equals(Right<dynamic, List<TodoList>>(tListTodos)));
    verify(() => repo.getAllTodoLists()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
