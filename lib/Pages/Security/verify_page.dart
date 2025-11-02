import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logos_messenger/Services/Data/api_helper.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  // Controllers for form inputs
  final TextEditingController _accessCodeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _accessCodeController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        showCloseIcon: true,
        dismissDirection: DismissDirection.down,
      ),
    );
  }

  Future<void> _handleVerify() async {
    setState(() {
      _isLoading = true;
    });

    final username = _accessCodeController.text.trim();
    if (username.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Please enter access code.');
      return;
    }
    if (username.length < 6) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Access code must be 6 characters long.');
      return;
    }

    try {
      // Perform verification logic here
      // For example, verify the access code with the server

      // Navigate to verification page
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/conversations', (Route<dynamic> route) => false);
    } on ApiException catch (e) {
      if (e.statusCode == 404) {
        _showSnackBar('No account found with that username.');
      } else {
        _showSnackBar('Server error: ${e.details ?? e.message}');
      }
    } catch (e) {
      // Network errors or unexpected issues
      _showSnackBar('An unexpected error occurred. Please try again.');
      debugPrint('Error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/intro_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          /// Semi-transparent overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withAlpha(102), // 0.4 opacity
                    Colors.black.withAlpha(153), // 0.6 opacity
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          /// Foreground content anchored to bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Logo
                  Image.asset(
                    'assets/images/logo2.png',
                    height: 100,
                  ),
                  const SizedBox(height: 40),

                  /// Title
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  /// Access Code Input
                  TextField(
                    controller: _accessCodeController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withAlpha(225),
                      hintText: 'Access Code',
                      hintStyle: TextStyle(color: Color(0xFF1B2336).withAlpha(90)), // 0.6 opacity
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF1B2336)),
                    ),
                    maxLength: 6,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  ),
                  const SizedBox(height: 20),

                  /// Verify Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B2336),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: _handleVerify,
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Cancel Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
