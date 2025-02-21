import 'package:samy/core/utils/spacing.dart';
import 'package:samy/core/widget/custom_button.dart';
import 'package:samy/core/widget/custom_text_field.dart';
import 'package:samy/screens/login/login_view.dart';
import 'package:samy/screens/sign_up/widgets/signUp_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SignUpFrom extends StatefulWidget {
  const SignUpFrom({
    super.key,
  });

  @override
  State<SignUpFrom> createState() => _SignUpFromState();
}

bool isobscureText = true;
bool isconfirmobscureText = true;

class _SignUpFromState extends State<SignUpFrom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const CustomTextField(
            prefixIcon: Icons.person,
            hintText: 'Name',
          ),
          verticalSpacing(height: 8),
          const CustomTextField(
            prefixIcon: Icons.email,
            hintText: 'Email',
          ),
          verticalSpacing(height: 8),
          const CustomTextField(
            prefixIcon: Icons.call,
            hintText: 'phone',
            keyboardType: TextInputType.phone,
            maxLength: 11,
          ),
          verticalSpacing(height: 8),
          const CustomTextField(
            prefixIcon: Icons.calendar_month,
            hintText: 'Age',
            keyboardType: TextInputType.phone,
            maxLength: 2,
          ),
          verticalSpacing(height: 8),
          GenderDropdownScreen(),
          verticalSpacing(height: 8),
          CustomTextField(
            prefixIcon: Icons.key,
            obsecureText: isobscureText,
            onTap: () {
              setState(() {
                isobscureText = !isobscureText;
              });
            },
            hintText: 'Password',
            suffixIcon: Icons.remove_red_eye_outlined,
          ),
          verticalSpacing(height: 8),
          CustomTextField(
            prefixIcon: Icons.key,
            obsecureText: isconfirmobscureText,
            onTap: () {
              setState(() {
                isconfirmobscureText = !isconfirmobscureText;
              });
            },
            hintText: 'Confirm Password',
            suffixIcon: Icons.remove_red_eye_outlined,
          ),
          verticalSpacing(height: 8),
          const CustomButton(),
          verticalSpacing(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('already have an account?'),
              TextButton(
                  onPressed: () {
                    Get.to(const LoginView());
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
