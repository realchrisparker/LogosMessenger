import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BiometricService {
  static final BiometricService _instance = BiometricService._internal();
  factory BiometricService() => _instance;
  BiometricService._internal();

  final _auth = LocalAuthentication();
  final _storage = const FlutterSecureStorage();
  final String _key = 'biometric_enabled';

  /// Check if device supports biometrics
  Future<bool> isBiometricAvailable() async {
    try {
      return await _auth.canCheckBiometrics && await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  /// Perform biometric authentication
  Future<bool> authenticate() async {
    try {
      final available = await isBiometricAvailable();
      if (!available) return false;

      return await _auth.authenticate(
        localizedReason: 'Authenticate to access Logos Messenger',
        biometricOnly: true,
      );
    } catch (e) {
      return false;
    }
  }

  /// Store preference
  Future<void> enableBiometric(bool enabled) async {
    await _storage.write(key: _key, value: enabled ? 'true' : 'false');
  }

  /// Check if user enabled biometrics
  Future<bool> isEnabled() async {
    final value = await _storage.read(key: _key);
    return value == 'true';
  }
}
