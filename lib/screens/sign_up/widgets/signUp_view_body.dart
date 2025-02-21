import 'package:samy/core/style/app_color.dart';
import 'package:samy/core/utils/spacing.dart';
import 'package:samy/screens/login/widget/logo_widget.dart';
import 'package:samy/screens/sign_up/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpacing(height: 30),
          const LogoWidget(),
          verticalSpacing(height: 24),
          const SignUpFrom()
        ],
      ),
    );
  }
}

class GenderDropdownScreen extends StatefulWidget {
  @override
  _GenderDropdownScreenState createState() => _GenderDropdownScreenState();
}

class _GenderDropdownScreenState extends State<GenderDropdownScreen> {
  // List of gender options
  final List<String> _genderOptions = ['Male', 'Female'];

  // Selected gender
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Select Gender',
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.defColor, width: 2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          value: _selectedGender,
          items: _genderOptions
              .map((gender) => DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
      ],
    );
  }
}
