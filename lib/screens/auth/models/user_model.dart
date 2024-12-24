import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String studentId; // Örn: 210404050
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? photoURL;
  final bool isEmailVerified;

  UserModel({
    required this.uid,
    required this.email,
    required this.studentId,
    this.displayName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.photoURL,
    this.isEmailVerified = false,
  });

  // Firebase User'dan UserModel oluşturma
  factory UserModel.fromFirebaseUser(User user) {
    // Öğrenci numarasını email'den çıkarma (210404050@st.biruni.edu.tr)
    String studentId = user.email?.split('@').first ?? '';

    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      studentId: studentId,
      displayName: user.displayName,
      phoneNumber: user.phoneNumber,
      photoURL: user.photoURL,
      isEmailVerified: user.emailVerified,
    );
  }
  // Model'i Map'e çevirme
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'studentId': studentId,
      'displayName': displayName,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'isEmailVerified': isEmailVerified,
    };
  }

  // Map'ten Model oluşturma
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      studentId: map['studentId'] ?? '',
      displayName: map['displayName'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      photoURL: map['photoURL'],
      isEmailVerified: map['isEmailVerified'] ?? false,
    );
  }

  // UserModel kopyalama (güncelleme için)
  UserModel copyWith({
    String? uid,
    String? email,
    String? studentId,
    String? displayName,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? photoURL,
    bool? isEmailVerified,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      studentId: studentId ?? this.studentId,
      displayName: displayName ?? this.displayName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
}
