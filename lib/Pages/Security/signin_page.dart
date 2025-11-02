import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logos_messenger/Services/Data/api_helper.dart';
import 'package:logos_messenger/Services/Data/data_service.dart';
import 'package:logos_messenger/Services/Security/biometric_service.dart';
import 'package:logos_messenger/Services/Session/session_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Controllers for form inputs
  final TextEditingController _userNameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _userNameController.dispose();
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

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    final username = _userNameController.text.trim();
    if (username.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Please enter your username.');
      return;
    }

    try {
      final dataService = DataService();
      final account = await dataService.getAccountByUserName(username);

      // Store globally
      SessionState().setAccount(account);

      // Navigate to verification page
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/verify');
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

    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   '/conversations', // your route name
    //   (Route<dynamic> route) => false, // remove all previous routes
    // );
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

                  /// User Name Input
                  TextField(
                    controller: _userNameController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withAlpha(225),
                      hintText: 'User name',
                      hintStyle: TextStyle(color: Color(0xFF1B2336).withAlpha(90)), // 0.6 opacity
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.phone_iphone, color: Color(0xFF1B2336)),
                    ),
                    maxLength: 60,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  ),
                  const SizedBox(height: 20),

                  /// Sign In Button
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
                      onPressed: _handleSignIn,
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Forgot password / signup links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ),
                      const Text(
                        '|',
                        style: TextStyle(color: Colors.white54),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
