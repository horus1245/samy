class User {
  String name;
  String phone;
  int age;
  String gender;
  String medicalCondition;

  User({
    required this.name,
    required this.phone,
    required this.age,
    required this.gender,
    required this.medicalCondition,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'age': age,
        'gender': gender,
        'medicalCondition': medicalCondition,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        phone: json['phone'],
        age: json['age'],
        gender: json['gender'],
        medicalCondition: json['medicalCondition'],
      );
}
