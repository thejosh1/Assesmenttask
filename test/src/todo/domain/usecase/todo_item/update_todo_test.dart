import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/update_todo.dart';

import 'todo_repo.mock.test.dart';

void main() {
  late UpdateTodoUsecase usecase;
  late MockTodoRepo repo;

  const tTodo = TodoItem.empty();
  const tUpdateParams = UpdateTodoUsecaseParams(
    todoId: 'todoId',
    todoItem: tTodo, isCompleted: true,
  );

  setUp(() {
    repo = MockTodoRepo();
    usecase = UpdateTodoUsecase(repo);

    registerFallbackValue(tTodo);
    registerFallbackValue(tUpdateParams);
  });

  test(
    'should return a [UpdateTodoUsecase]',
    () async {
      when(
        () => repo.updateTodo(
          todoId: any(named: 'todoId'),
          todoItem: any(named: 'todoItem'),
          isCompleted: any(named: 'isCompleted'),
        ),
      ).thenAnswer((_) async => const Right(null));
      final result = await usecase(tUpdateParams);
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repo.updateTodo(
          todoId: tUpdateParams.todoId,
          todoItem: tUpdateParams.todoItem,
          isCompleted: tUpdateParams.isCompleted,
        ),
      ).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
