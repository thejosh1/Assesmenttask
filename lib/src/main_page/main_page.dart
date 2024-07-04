import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/commons/app/user_provider.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';
import 'package:pridera_assesment_task/core/services/injection_container/injector_container.dart';
import 'package:pridera_assesment_task/src/auth/data/model/local_user_model.dart';
import 'package:pridera_assesment_task/src/main_page/providers/main_page_controller.dart';
import 'package:pridera_assesment_task/src/main_page/utils/main_page_utils.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoListCubit/todo_list_cubit.dart';
import 'package:pridera_assesment_task/src/todo/presentation/views/add_todo.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const routeName = '/main-page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUserModel>(
      stream: MainPageUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data is LocalUserModel) {
          context.read<UserProvider>().user = snapshot.data;
        }
        return Consumer<MainPageController>(
          builder: (_, controller, __) {
            return Scaffold(
              body: IndexedStack(
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: BottomAppBar(
                surfaceTintColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildNavItem(MediaRes.homeIcon, 'Home', 0, controller),
                    _buildNavItem(
                      MediaRes.settingsIcon, 'Settings', 1, controller,),
                  ],
                ),
              ),
              floatingActionButton: controller.currentIndex == 0
                  ? SizedBox(
                width: 64.w,
                height: 64.h,
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: AppColors.primaryColor,
                  child: Center(
                    child: Image.asset(
                      MediaRes.addIcon,
                      width: 21.33.w,
                      height: 21.33.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onPressed: () {
                    // Handle FAB press
                    //extra unnecessary check
                    if (controller.currentIndex == 0) {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => BlocProvider(
                            create: (_) => sl<TodoListCubit>(),
                            child: const AddTodo(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
                  : null,
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
            );
          },
        );
      },
    );
  }

  Widget _buildNavItem(
    String assetName,
    String label,
    int index,
    MainPageController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              assetName,
              width: 24.sp,
              height: 24.sp,
              color: controller.currentIndex == index
                  ? AppColors.primaryColor
                  : AppColors.darkGrey,
            ),
            SizedBox(height: 4.sp),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: controller.currentIndex == index
                    ? AppColors.primaryColor
                    : AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
