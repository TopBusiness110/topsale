import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/preferences/preferences.dart';
import 'package:topsale/core/utils/app_assets.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/app_colors.dart';
import '../components/more_list_item.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 25.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(64),
                      topLeft: Radius.circular(64)),
                  color: AppColors.lightBlue,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 9.h,
                    ),
                    InkWell(
                      onTap: () async {
                        print(")))))))))))))))))))))))))))))))))))))))))))");
                        await launchURLBrowser();
                        //  await launchURLInApp();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "www.topbusiness.io",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.white,
                              child: Image.asset(
                                "assets/images/more/globe3.png",
                                color: AppColors.lightBlue,
                                width: 22,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        //To remove the keyboard when button is pressed
                        FocusManager.instance.primaryFocus?.unfocus();

                        var whatsappUrl = "whatsapp://send?phone=+201011827324"
                            "&text=${Uri.encodeComponent("top sale customer service")}";
                        try {
                          launch(whatsappUrl);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Unable to open whatsapp")));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "+201011827324",
                              style: Theme.of(context).textTheme.bodySmall,
                              textDirection: TextDirection.ltr,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const CircleAvatar(
                                radius: 12,
                                backgroundColor: AppColors.white,
                                child: Icon(
                                  Icons.phone,
                                  color: AppColors.lightBlue,
                                  size: 20,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 5.h,
                      child: Image.asset(
                        AssetsManager.whiteCopyRights,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: SizedBox(
                height: 60.h,
                child: ListView.builder(
                  itemCount: labels.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          if (index == 0) {
                            Navigator.pushNamed(context, Routes.myAccountRoute);
                          }
                           else if (index == 2) {
                            Navigator.pushNamed(context, Routes.reportsRoute);
                          }
                          else if (index == 3) {
                            showAlertDialog(context);
                          } else if (index == 4) {
                            context.read<HomeCubit>().changeTabs(0);
                            Preferences.instance.removeUserName();
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.loginRoute, (route) => false);
                          }
                        },
                        child: MoreListItem(
                          text: labels[index],
                          imagePath: moreImages[index],
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.white,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        title: Center(
          child: Text(
            "delete_account".tr(),
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: AppColors.lightBlue,
                ),
          ),
        ),
        content: Text(
          "sure_delete_account".tr(),
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppColors.lightBlue, fontSize: 14),
        ),
        actions: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(28.w, 5.h),
                  maximumSize: Size(30.w, 5.h),
                  backgroundColor: AppColors.red,
                ),
                child: Text(
                  "yes_delete".tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightBlue,
                  minimumSize: Size(28.w, 5.h),
                  maximumSize: Size(30.w, 5.h),
                ),
                child: Text(
                  "no".tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}

launchURLBrowser() async {
  const url = 'https://www.topbusiness.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

launchURLInApp() async {
  const url = 'https://www.topbusiness.io';
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}
