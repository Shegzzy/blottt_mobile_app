import 'package:blott_mobile_app/src/data/controller/news_controller.dart';
import 'package:blott_mobile_app/src/data/repository/news_repository.dart';
import 'package:blott_mobile_app/src/screens/news_screen.dart';
import 'package:blott_mobile_app/src/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'src/binding/dependencies/dependencies.dart' as dep;

Future<void> main() async {
  runApp(const MyApp());
  await dep.init();
  await GetStorage.init();
  await Get.find<GeneralNewsController>().getUserData();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralNewsController>(builder: (newsController) {
      return GetMaterialApp(
        title: 'Blott',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: newsController.firstName.isNotEmpty ? const NewsScreen() : const SignUpScreen(),
      );
    });
  }
}
