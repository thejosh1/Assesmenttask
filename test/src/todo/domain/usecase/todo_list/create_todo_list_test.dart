import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_list/create_todo_list.dart';


import 'todo_list_repo.mock.test.dart';

void main() {
  late MockTodoListRepo repo;
  late CreateTodoListUsecase usecase;

  const todoItem = TodoItem.empty();
  const tTodoItemsList = <TodoItem>[todoItem];
  final tTodoList = const TodoList.empty();

  setUp(() {
    repo = MockTodoListRepo();
    usecase = CreateTodoListUsecase(repo);
    registerFallbackValue(tTodoItemsList);
    registerFallbackValue(tTodoList);
  });

  test('should return [TodoList] from the [TodoListRepo]', () async {
    when(
      () => repo.createTodoList(todoList: any(named: 'todoList')),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(
      CreateTodoListParams(todoList: tTodoList),
    );
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repo.createTodoList(todoList: tTodoList))
        .called(1);
    verifyNoMoreInteractions(repo);
  });
}
