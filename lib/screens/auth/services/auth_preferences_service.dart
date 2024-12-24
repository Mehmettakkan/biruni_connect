// lib/screens/auth/services/auth_preferences_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Base64 şifreleme için

// Kullanıcı tercihlerini ve kimlik bilgilerini yerel depolama üzerinde yöneten servis
class AuthPreferencesService {
  // Shared Preferences için anahtar sabitleri
  static const String _rememberMeKey = 'remember_me';
  static const String _userEmailKey = 'user_email';
  static const String _userPasswordKey =
      'user_password'; // Şifrelenmiş olarak saklanır

  // Şifreleme için kullanılacak secret key (gerçek uygulamada daha güvenli bir yöntem kullanılmalı)
  static const String _encryptionKey = 'your_secret_key_here';

  final SharedPreferences _prefs;

  AuthPreferencesService(this._prefs);

  // Singleton pattern ile servis oluşturma
  static Future<AuthPreferencesService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AuthPreferencesService(prefs);
  }

  // Basit şifreleme metodu (örnek amaçlı - production'da daha güvenli bir yöntem kullanılmalı)
  String _encryptPassword(String password) {
    // ignore: unused_local_variable
    final key = utf8.encode(_encryptionKey);
    final bytes = utf8.encode(password);
    final encrypted = base64.encode(bytes);
    return encrypted;
  }

  // Şifre çözme metodu
  String _decryptPassword(String encryptedPassword) {
    try {
      final decrypted = base64.decode(encryptedPassword);
      return utf8.decode(decrypted);
    } catch (e) {
      print('Decryption error: $e');
      return '';
    }
  }

  // "Beni Hatırla" durumunu ayarlama
  Future<void> setRememberMe(bool value) async {
    await _prefs.setBool(_rememberMeKey, value);
  }

  // "Beni Hatırla" durumunu getirme
  bool getRememberMe() {
    return _prefs.getBool(_rememberMeKey) ?? false;
  }

  // Kullanıcı kimlik bilgilerini kaydetme (Beni Hatırla için)
  Future<void> saveUserCredentials(String email, String password) async {
    try {
      if (getRememberMe()) {
        await _prefs.setString(_userEmailKey, email);
        // Şifreyi şifreleyerek sakla
        final encryptedPassword = _encryptPassword(password);
        await _prefs.setString(_userPasswordKey, encryptedPassword);
      }
    } catch (e) {
      print('Error saving credentials: $e');
      rethrow;
    }
  }

  // Kaydedilmiş kimlik bilgilerini getirme
  Map<String, String?> getSavedCredentials() {
    try {
      final email = _prefs.getString(_userEmailKey);
      final encryptedPassword = _prefs.getString(_userPasswordKey);

      return {
        'email': email,
        'password': encryptedPassword != null
            ? _decryptPassword(encryptedPassword)
            : null,
      };
    } catch (e) {
      print('Error getting credentials: $e');
      return {'email': null, 'password': null};
    }
  }

  // Kaydedilmiş kimlik bilgilerini silme
  Future<void> clearSavedCredentials() async {
    try {
      await _prefs.remove(_userEmailKey);
      await _prefs.remove(_userPasswordKey);
    } catch (e) {
      print('Error clearing credentials: $e');
      rethrow;
    }
  }

  // Tüm auth verilerini temizleme
  Future<void> clearAllAuthData() async {
    try {
      await clearSavedCredentials();
      // Eğer "Beni Hatırla" seçili değilse, o ayarı da temizle
      if (!getRememberMe()) {
        await _prefs.remove(_rememberMeKey);
      }
    } catch (e) {
      print('Error clearing auth data: $e');
      rethrow;
    }
  }

  // Local storage'da belirli bir key'in varlığını kontrol etme
  Future<bool> hasKey(String key) async {
    return _prefs.containsKey(key);
  }

  // Local storage'dan belirli bir değeri silme
  Future<bool> removeKey(String key) async {
    return await _prefs.remove(key);
  }
}
