import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/commons/app/todo_provider.dart';
import 'package:pridera_assesment_task/core/commons/app/user_provider.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/core/res/fonts.dart';
import 'package:pridera_assesment_task/core/services/injection_container/injector_container.dart';
import 'package:pridera_assesment_task/core/services/navigator_service.dart';
import 'package:pridera_assesment_task/core/services/routes/routes.dart';
import 'package:pridera_assesment_task/firebase_options.dart';
import 'package:pridera_assesment_task/src/main_page/providers/main_page_controller.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 730),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => UserProvider()),
              ChangeNotifierProvider(create: (_) => MainPageController()),
              ChangeNotifierProvider(create: (_) => TodoProvider()),
            ],
          child: MaterialApp(
            title: 'MyArteLab',
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
              ),
              useMaterial3: true,
              fontFamily: Fonts.inter,
              scaffoldBackgroundColor: Colors.white,
            ),
            onGenerateRoute: AppRouter.generateRoute,
            navigatorKey: sl<NavigatorService>().navigatorKey,
          ),
        );
      },
    );
  }
}
