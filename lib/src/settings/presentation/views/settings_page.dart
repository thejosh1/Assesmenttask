import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/commons/app/user_provider.dart';
import 'package:pridera_assesment_task/core/commons/views/utils/app_utils.dart';
import 'package:pridera_assesment_task/core/commons/views/widgets/global_app_bar.dart';
import 'package:pridera_assesment_task/core/extensions/context_extensions.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';
import 'package:pridera_assesment_task/core/utility/app_routes.dart';
import 'package:pridera_assesment_task/src/auth/data/model/local_user_model.dart';
import 'package:pridera_assesment_task/src/auth/presentation/auth/auth_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final email = context.currentUser!.email;
    final fullName = context.currentUser!.fullName;
    return Scaffold(
      appBar: const GlobalAppBar(
        titleText: 'Settings',
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            AppUtils.showSnackBar(context, state.errorMessage);
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
          }
        },
        builder: (_, state) {
          return Padding(
            padding: EdgeInsets.only(
              top: 24.h,
              left: 16.w,
              right: 16.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: AppColors.lightTitle,
                      size: 12.sp,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      email,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightTitle,),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColors.borderColor,
                ),
                SizedBox(
                  height: 28.h,
                ),
                GestureDetector(
                  onTap: () {
                    AppUtils.showDialogueButton(context, () async {
                      final navigator = Navigator.of(context);
                      await FirebaseAuth.instance.signOut();
                      unawaited(
                        navigator.pushNamedAndRemoveUntil(
                          AppRoute.init,
                          (route) => false,
                        ),
                      );
                    });
                  },
                  child: SizedBox(
                    child: Row(
                      children: [
                        Image.asset(
                          MediaRes.logoutIcon,
                          fit: BoxFit.cover,
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: AppColors.errorColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
