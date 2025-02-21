// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:samy/core/models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   ProfilePageState createState() => ProfilePageState();
// }

// class ProfilePageState extends State<ProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   late User user;

//   @override
//   void initState() {
//     super.initState();
//     user = User(
//       name: '',
//       phone: '',
//       age: 0,
//       gender: 'ذكر',
//       medicalCondition: '',
//     );
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userData = prefs.getString('user_data');
//     if (userData != null) {
//       setState(() {
//         user = User.fromJson(json.decode(userData));
//       });
//     }
//   }

//   Future<void> _saveUserData() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('user_data', json.encode(user.toJson()));

//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('تم حفظ البيانات بنجاح'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('الملف الشخصي'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: _saveUserData,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'الاسم بالكامل',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.person),
//                 ),
//                 initialValue: user.name,
//                 textDirection: TextDirection.rtl,
//                 onSaved: (value) => user.name = value ?? '',
//                 validator: (value) =>
//                 value?.isEmpty ?? true ? 'برجاء إدخال الاسم' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'رقم الهاتف',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.phone),
//                 ),
//                 initialValue: user.phone,
//                 keyboardType: TextInputType.phone,
//                 textDirection: TextDirection.ltr,
//                 onSaved: (value) => user.phone = value ?? '',
//                 validator: (value) =>
//                 value?.isEmpty ?? true ? 'برجاء إدخال رقم الهاتف' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'العمر',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.calendar_today),
//                 ),
//                 initialValue: user.age.toString(),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => user.age = int.tryParse(value ?? '0') ?? 0,
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'برجاء إدخال العمر';
//                   }
//                   final age = int.tryParse(value!);
//                   if (age == null || age < 0 || age > 120) {
//                     return 'برجاء إدخال عمر صحيح';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(
//                   labelText: 'النوع',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.people),
//                 ),
//                 value: user.gender,
//                 items: ['ذكر', 'أنثى']
//                     .map((label) => DropdownMenuItem(
//                   value: label,
//                   child: Text(label),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     user.gender = value!;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'الحالة الصحية',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.medical_services),
//                 ),
//                 initialValue: user.medicalCondition,
//                 maxLines: 3,
//                 textDirection: TextDirection.rtl,
//                 onSaved: (value) => user.medicalCondition = value ?? '',
//                 validator: (value) =>
//                 value?.isEmpty ?? true ? 'برجاء إدخال الحالة الصحية' : null,
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: _saveUserData,
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'حفظ البيانات',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samy/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late User user;

  @override
  void initState() {
    super.initState();
    user = User(
      name: '',
      phone: '',
      age: 0,
      gender: 'ذكر',
      medicalCondition: '',
    );
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    if (userData != null) {
      setState(() {
        user = User.fromJson(json.decode(userData));
      });
    }
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', json.encode(user.toJson()));

      await _updateProfile();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ البيانات بنجاح'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _updateProfile() async {
    final url = Uri.parse(
        'https://2d43-154-177-204-132.ngrok-free.app/update-profile/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      if (response.statusCode == 200) {
        print('تم تحديث البيانات بنجاح');
      } else {
        print('خطأ في تحديث البيانات: ${response.body}');
      }
    } catch (e) {
      print('حدث خطأ أثناء الاتصال بالخادم: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveUserData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'الاسم بالكامل',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                initialValue: user.name,
                textDirection: TextDirection.rtl,
                onSaved: (value) => user.name = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'برجاء إدخال الاسم' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                initialValue: user.phone,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                onSaved: (value) => user.phone = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'برجاء إدخال رقم الهاتف' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'العمر',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                initialValue: user.age.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => user.age = int.tryParse(value ?? '0') ?? 0,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'برجاء إدخال العمر';
                  }
                  final age = int.tryParse(value!);
                  if (age == null || age < 0 || age > 120) {
                    return 'برجاء إدخال عمر صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'النوع',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                ),
                value: user.gender,
                items: ['ذكر', 'أنثى']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    user.gender = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'الحالة الصحية',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medical_services),
                ),
                initialValue: user.medicalCondition,
                maxLines: 3,
                textDirection: TextDirection.rtl,
                onSaved: (value) => user.medicalCondition = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'برجاء إدخال الحالة الصحية' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveUserData,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'حفظ البيانات',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
