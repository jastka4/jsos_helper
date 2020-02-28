import 'package:jsos_helper/common/university.dart';
import 'package:meta/meta.dart';

class User {
  final int id;
  final String username;
  final String fullName;
  final String studentNumber;
  final String faculty;
  final String subject;
  final String degree;
  final String specialization;
  final University university;
  final String image;

  User({
    this.id,
    this.specialization,
    this.image,
    this.username,
    this.degree,
    @required this.fullName,
    @required this.studentNumber,
    @required this.faculty,
    @required this.subject,
    @required this.university,
  });

  factory User.fromMap(Map<String, dynamic> map) => new User(
        id: map["id"],
        username: map["username"],
        fullName: map["full_name"],
        studentNumber: map["student_number"],
        faculty: map["faculty"],
        subject: map["subject"],
        degree: map["degree"],
        specialization: map["specialization"],
        university: University.values[map["university"]],
        image: map["image"],
      );

  factory User.fromJson(Map<String, dynamic> json) => new User(
        fullName: json["fullName"],
        studentNumber: json["studentNumber"],
        faculty: json["faculty"],
        subject: json["subject"],
        degree: json["degree"],
        specialization: json["specialization"],
        university: University.values[json["university"]],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "full_name": fullName,
        "student_number": studentNumber,
        "faculty": faculty,
        "subject": subject,
        "degree": degree,
        "specialization": specialization,
        "university": university,
        "image": image,
      };

  @override
  String toString() {
    return 'User{id: $id, username: $username, fullName: $fullName, studentNumber: $studentNumber, faculty: $faculty, subject: $subject, degree: $degree, specialization: $specialization, university: $university, image: $image}';
  }
}
