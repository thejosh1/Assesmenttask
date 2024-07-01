import 'package:pridera_assesment_task/core/services/injection_container/injector_container.dart';
import 'package:pridera_assesment_task/core/services/navigator_service.dart';

class AppRoute {
  static const splash = '/';
  static const home = '/home';
  static const init = '/init';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const createTodo = '/create-todo';
  static Future<dynamic> go(
      String destination, {dynamic arguments, bool? pop, bool? popAll,
      }) async {
    if (pop ??= true) {
      return await sl<NavigatorService>().popNavigateTo(
        destination,
        arguments: arguments,
      );
    } else if (popAll ??= true) {
      return await sl<NavigatorService>().popAllNavigateTo(
        destination,
        arguments: arguments,
      );
    } else {
      return await sl<NavigatorService>().navigateTo(
        destination,
        arguments: arguments,
      );
    }
  }

  static pop<T extends Object>([T? result]) {
    return sl<NavigatorService>().pop(result);
  }
}
