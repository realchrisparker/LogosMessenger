import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyService {
  static const _privateKeyKey = 'mcs_e2e_private_key_x25519'; // your name here
  final _storage = const FlutterSecureStorage();
  final _algorithm = X25519(); // curve25519 for key exchange

  /// Call this on app startup
  Future<SimpleKeyPair> getOrCreateKeyPair() async {
    // 1. try to load existing private key
    final storedPrivateKeyBase64 = await _storage.read(key: _privateKeyKey);

    if (storedPrivateKeyBase64 != null) {
      // restore
      final privateKeyBytes = base64Decode(storedPrivateKeyBase64);
      final keyPair = await _algorithm.newKeyPairFromSeed(privateKeyBytes);
      return keyPair;
    }

    // 2. create new key pair
    final keyPair = await _algorithm.newKeyPair();
    final keyPairData = await keyPair.extractPrivateKeyBytes(); // 32 bytes

    // 3. store private key securely
    await _storage.write(key: _privateKeyKey, value: base64Encode(keyPairData));

    return keyPair;
  }

  /// Get public key (to send to server)
  Future<List<int>> getPublicKeyBytes() async {
    final keyPair = await getOrCreateKeyPair();
    final publicKey = await keyPair.extractPublicKey();
    return publicKey.bytes;
  }

  /// Convenience for API payload
  Future<String> getPublicKeyBase64() async {
    final bytes = await getPublicKeyBytes();
    return base64Encode(bytes);
  }
}
