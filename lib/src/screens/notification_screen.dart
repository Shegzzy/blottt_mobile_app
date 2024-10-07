import 'package:blott_mobile_app/src/data/controller/news_controller.dart';
import 'package:blott_mobile_app/src/screens/news_screen.dart';
import 'package:blott_mobile_app/src/utils/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/fonts_sizes.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/notification_image.png', scale: 2/1,),

              const SizedBox(height: 10,),
              Text(
                'Get the most out of Blott ✅',
                style: Fonts.fontRobot(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: AppColors.subTitleColor),
              ),

              const SizedBox(height: 10),
              Text(
                'Allow notifications to stay in the loop with your payments, requests and groups.',
                textAlign: TextAlign.center,
                style: Fonts.fontRobot(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.greyTextColor),
              ),


            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width24, vertical: Dimensions.height8),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                foregroundColor: WidgetStateProperty.all(AppColors.whiteColor),
                padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
              ),
              onPressed: () async {
                await requestPermission(permission: Permission.notification);
              },
              child: Text('Continue', style: Fonts.fontRobot(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.whiteColor),))),
    );
  }

  Future<void> requestPermission({required Permission permission}) async{
    final status = await permission.status;

    if(status.isGranted){
      Get.find<GeneralNewsController>().getUserData();
      Get.to(() => const NewsScreen());
      debugPrint('Already granted');
    } else if(status.isDenied) {
      if(await permission.request().isGranted){
        Get.find<GeneralNewsController>().getUserData();
        Get.to(() => const NewsScreen());
        debugPrint('Granted');
      } else {
        debugPrint('Not Granted');
      }
    }else {
      debugPrint('Not Granted');
    }
  }
}
