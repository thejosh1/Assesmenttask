part of 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return _buildRoute(
          (_) => const SplashScreen(),
          settings: settings,
        );
      case AppRoute.init:
        final prefs = sl<SharedPreferences>();
        return _buildRoute(
          (context) {
            if (prefs.getBool(kFirstTimerKey) ?? true) {
              return BlocProvider(
                create: (_) => sl<OnboardingCubit>(),
                child: const OnboardingScreen(),
              );
            } else if (sl<FirebaseAuth>().currentUser != null) {
              final user = sl<FirebaseAuth>().currentUser!;
              final localUser = LocalUserModel(
                uid: user.uid,
                email: user.email ?? '',
                fullName: user.displayName ?? '',
              );
              context.userProvider.initUser(localUser);
              return const MainPage();
            }
            return BlocProvider(
              create: (_) => sl<AuthBloc>(),
              child: const SignInScreen(),
            );
          },
          settings: settings,
        );
      case AppRoute.signIn:
        return _buildRoute(
          (_) => BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          ),
          settings: settings,
        );
      case AppRoute.signUp:
        return _buildRoute(
          (_) => BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignUpScreen(),
          ),
          settings: settings,
        );
      case AppRoute.forgotPassword:
        return _buildRoute(
          (_) => const fui.ForgotPasswordScreen(),
          settings: settings,
        );
      case AppRoute.home:
        return _buildRoute((_) => const MainPage(), settings: settings);
      case AppRoute.createTodo:
        return _buildRoute(
          (_) => BlocProvider(
            create: (_) => sl<TodoListCubit>(),
            child: const AddTodo(),
          ),
          settings: settings,
        );
      default:
        return _buildRoute(
          (_) => const Scaffold(
            body: Center(
              child: Text('Invalid route reached.'),
            ),
          ),
          settings: settings,
        );
    }
  }
}

Widget _transitionHandler(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child,) {
  const begin = Offset(0, 1);
  const end = Offset.zero;
  const curve = Curves.ease;
  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: animation.drive(tween),
      child: child,
    ),
  );
}

Duration _forward() {
  return const Duration(milliseconds: 200);
}

Duration _reverse() {
  return const Duration(milliseconds: 200);
}

PageRouteBuilder _buildRoute(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => page(context),
    transitionsBuilder: _transitionHandler,
    transitionDuration: _forward(),
    reverseTransitionDuration: _reverse(),
  );
}
