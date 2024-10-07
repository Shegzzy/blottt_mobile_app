import 'package:blott_mobile_app/src/data/controller/news_controller.dart';
import 'package:blott_mobile_app/src/screens/news_screen.dart';
import 'package:blott_mobile_app/src/screens/notification_screen.dart';
import 'package:blott_mobile_app/src/utils/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/fonts_sizes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  bool _isFormValid = false; // Track form validity

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var name = Get.find<GeneralNewsController>().firstName;
      if(name.isNotEmpty){
        Get.to(() => const NewsScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralNewsController>(builder: (newsController) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height24),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width24),
            child: Form(
              key: _formKey, // Attach the form key
              onChanged: _validateForm, // Validate form on every change
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your legal name',
                    style: Fonts.fontRobot(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: AppColors.titleColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'We need to know a bit about you so that we can create your account.',
                    style: Fonts.fontRobot(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.greyTextColor),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    enableInteractiveSelection: true,
                    controller: firstNameController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      hintStyle: Fonts.fontRobot(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: AppColors.hintTextColor),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.inputBorderColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.inputBorderColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'First name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      hintStyle: Fonts.fontRobot(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: AppColors.hintTextColor),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.inputBorderColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.inputBorderColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Last name is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: !_isFormValid ? null : () async{
            if (_formKey.currentState?.validate() ?? false) {
              await newsController.storeUserData(firstNameController.text.trim(), lastNameController.text.trim());
              Get.to(() => const NotificationScreen());
            }
          },
          elevation: 0,
          backgroundColor: _isFormValid ? AppColors.primaryColor : AppColors
              .primaryColor.withOpacity(0.5),
          child: const Icon(
            Icons.arrow_forward_ios, color: AppColors.whiteColor,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    });
  }
}
