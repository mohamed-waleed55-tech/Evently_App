import 'package:evently/DM/userDM.dart';
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/core/utils/dialog.dart';
import 'package:evently/features/main_layout/tabs/profile/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/firebase_service/firestore/auth_service.dart';
import '../../../../../l10n/app_localizations.dart';



class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedLanguage = "English";
  String selectedMode = "Light";

  final List<String> languages = ["English", "Arabic"];
  final List<String> modes = ["Light", "Dark"];


  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 220.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: ColorsManager.blue,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64.r)),
          ),
          child: Row(
            children: [
              Image.asset(
                ImagesManager.routeLogo,
                width: 80.w,
                height: 80.w,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    UserDM.currentUser!.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    UserDM.currentUser!.email,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.language,

                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontSize: 20),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: REdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ColorsManager.blue, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      configProvider.isEnglish ? "English" : "Arabic",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),

                    DropdownButton<String>(
                      underline: Container(),
                      items: languages.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: ColorsManager.blue),
                          ),
                        );
                      }).toList(),
                      onChanged: (newLang) {
                        configProvider.changeLang(
                          newLang == "English" ? "en" : "ar",
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context)!.theme,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontSize: 20),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: REdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ColorsManager.blue, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      configProvider.isLight ? "Light" : "Dark",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    DropdownButton<String>(
                      underline: Container(),
                      items: modes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: ColorsManager.blue),
                          ),
                        );
                      }).toList(),
                      onChanged: (theme) {
                        configProvider.changeTheme(
                          theme == "Light" ? ThemeMode.light : ThemeMode.dark,
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 130.h),

              ElevatedButton(
                onPressed: logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.red,
                ),
                child: Padding(
                  padding: REdgeInsets.only(right: 16, left: 16),
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 10.w),
                      Text(AppLocalizations.of(context)!.logout),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void logout() async {
    DialogUtils.showMessage(
      context,
      message: "Are you sure you want to logout?",
      posActionTitle: "Ok",
      posAction: () async{
        await AuthService.logout();


        Navigator.pushReplacementNamed(context, RoutesManager.signIn);
      },
        title: "Logout",
      negActionTitle: "Cancel",
    );
  }
}
