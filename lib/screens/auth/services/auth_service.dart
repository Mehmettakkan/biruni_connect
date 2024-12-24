// lib/screens/auth/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import 'auth_preferences_service.dart';

// Auth işlemleri sırasında oluşabilecek hata mesajları
class AuthError {
  static const String invalidBiruniEmail =
      'Lütfen Biruni mail hesabınız ile giriş yapın';
  static const String userNotFound = 'Kullanıcı bulunamadı';
  static const String wrongPassword = 'Hatalı şifre';
  static const String emailAlreadyInUse = 'Bu email zaten kullanımda';
  static const String weakPassword = 'Şifre çok zayıf';
  static const String invalidEmail = 'Geçersiz email formatı';
  static const String networkError = 'İnternet bağlantınızı kontrol edin';
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthPreferencesService _preferencesService;

  AuthService(this._preferencesService);

  // Singleton pattern ile service oluşturma
  static Future<AuthService> create() async {
    final preferencesService = await AuthPreferencesService.create();
    return AuthService(preferencesService);
  }

  // Current user stream'ini UserModel'e çeviriyoruz
  // Bu stream sayesinde kullanıcının auth durumunu gerçek zamanlı takip edebiliriz
  Stream<UserModel?> get userStream => _auth.authStateChanges().map(
        (user) => user != null ? UserModel.fromFirebaseUser(user) : null,
      );

  // Current user getter'ı UserModel'e çeviriyoruz
  // Anlık kullanıcı bilgisini almak için bu getter'ı kullanabiliriz
  UserModel? get currentUser => _auth.currentUser != null
      ? UserModel.fromFirebaseUser(_auth.currentUser!)
      : null;

  // Email'in Biruni uzantılı olup olmadığını kontrol eden metod
  bool isValidBiruniEmail(String email) {
    return email.endsWith('@st.biruni.edu.tr');
  }

  // Firebase Auth hatalarını yöneten helper metod
  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthError.userNotFound;
      case 'wrong-password':
        return AuthError.wrongPassword;
      case 'email-already-in-use':
        return AuthError.emailAlreadyInUse;
      case 'weak-password':
        return AuthError.weakPassword;
      case 'invalid-email':
        return AuthError.invalidEmail;
      case 'network-request-failed':
        return AuthError.networkError;
      default:
        return 'Bir hata oluştu: ${e.message}';
    }
  }

  // Google ile giriş yapma metodu
  Future<UserModel?> signInWithGoogle() async {
    try {
      // Google sign-in popup'ını aç
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // Kullanıcı popup'ı kapattı

      // Email kontrolü
      if (!isValidBiruniEmail(googleUser.email)) {
        throw AuthError.invalidBiruniEmail;
      }

      // Google auth bilgilerini al
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Firebase credential oluştur
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase'de oturum aç
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user != null
          ? UserModel.fromFirebaseUser(userCredential.user!)
          : null;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      print('Google sign in error: $e');
      rethrow;
    }
  }

  // Email/password ile giriş yapma metodu
  Future<UserModel?> signInWithEmail({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      // Email kontrolü
      if (!isValidBiruniEmail(email)) {
        throw AuthError.invalidBiruniEmail;
      }

      // Firebase'de oturum aç
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Remember me aktifse bilgileri kaydet
      if (rememberMe) {
        await _preferencesService.setRememberMe(true);
        await _preferencesService.saveUserCredentials(email, password);
      }

      return userCredential.user != null
          ? UserModel.fromFirebaseUser(userCredential.user!)
          : null;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      print('Email sign in error: $e');
      rethrow;
    }
  }

  // Email/password ile kayıt olma metodu
  Future<UserModel?> registerWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      // Email kontrolü
      if (!isValidBiruniEmail(email)) {
        throw AuthError.invalidBiruniEmail;
      }

      // Firebase'de yeni kullanıcı oluştur
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Email doğrulama maili gönder
      await userCredential.user?.sendEmailVerification();

      return userCredential.user != null
          ? UserModel.fromFirebaseUser(userCredential.user!)
          : null;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      print('Register error: $e');
      rethrow;
    }
  }

  // Çıkış yapma metodu
  Future<void> signOut() async {
    try {
      // Tüm oturumları kapat ve local verileri temizle
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
        _preferencesService.clearAllAuthData(),
      ]);
    } catch (e) {
      print('Sign out error: $e');
      rethrow;
    }
  }

  // Şifre sıfırlama maili gönderme metodu
  Future<void> resetPassword(String email) async {
    try {
      // Email kontrolü
      if (!isValidBiruniEmail(email)) {
        throw AuthError.invalidBiruniEmail;
      }
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      print('Password reset error: $e');
      rethrow;
    }
  }

  // Email doğrulama maili gönderme metodu
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      print('Email verification error: $e');
      rethrow;
    }
  }

  // Şifre güncelleme metodu
  Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      print('Password update error: $e');
      rethrow;
    }
  }

  // Kaydedilmiş kullanıcı bilgilerini kontrol et
  Future<Map<String, String?>> getSavedCredentials() async {
    return _preferencesService.getSavedCredentials();
  }
}
