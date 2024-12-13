import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:med_alert/core/presentation/widgets/custom_button.dart';
import 'package:med_alert/core/presentation/widgets/svg_image.dart';
import 'package:med_alert/core/resources/assets.dart';
import 'package:med_alert/core/resources/colors.dart';
import 'package:med_alert/core/resources/strings.dart';
import 'package:med_alert/core/resources/values.dart';
import 'package:med_alert/features/authentication/presentation/view/login_view.dart';
import 'package:med_alert/features/authentication/presentation/view/register_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundSecondary,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 36, horizontal: 14).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgImage(
              radius: AppRadius.large,
              assetName: AppAssets.welcome,
              width: AppWidth.screenWidth,
            ),
            Column(
              children: [
                Text(
                  AppStrings.welcomeTitle,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),
                SizedBox(height: AppHeight.h6.h),
                Padding(
                  padding: AppPadding.smallH.w,
                  child: Text(
                    AppStrings.welcomeDescription,
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            _authButtonRaw(context),
          ],
        ),
      ),
    );
  }

  // Updated method for handling authentication button navigation directly without GoRouter
  Widget _authButtonRaw(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.white),
        borderRadius: const BorderRadius.all(Radius.circular(11)).w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: CustomButton(
              lable: AppStrings.registerTitle,
              onTap: () {
                // Directly navigate to the RegisterForm without router
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterView()),
                );
              },
              backgroundColor: AppColors.accent,
              textColor: AppColors.white,
            ),
          ),
          Flexible(
            child: CustomButton(
              lable: AppStrings.login,
              onTap: () {
                // Directly navigate to the LoginForm without router
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              backgroundColor: AppColors.white,
              textColor: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
