import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for form inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    debugPrint('Email: ${_emailController.text}');
    debugPrint('Password: ${_passwordController.text}');
    await Navigator.pushNamed(context, '/signup');
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
                  const SizedBox(height: 30),

                  /// Title
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.name,
                          autofillHints: const [AutofillHints.givenName],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withAlpha(225),
                            hintText: 'First Name',
                            hintStyle: TextStyle(color: Color(0xFF1B2336).withAlpha(90)), // 0.6 opacity
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.person, color: Color(0xFF1B2336)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.name,
                          autofillHints: const [AutofillHints.familyName],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withAlpha(225),
                            hintText: 'Last Name',
                            hintStyle: TextStyle(color: Color(0xFF1B2336).withAlpha(90)), // 0.6 opacity
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.person, color: Color(0xFF1B2336)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Phone Input
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withAlpha(225),
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Color(0xFF1B2336).withAlpha(90)), // 0.6 opacity
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.phone_iphone, color: Color(0xFF1B2336)),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Email Input
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withAlpha(225),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Color(0xFF1B2336).withAlpha(90)), // 0.6 opacity
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.phone_iphone, color: Color(0xFF1B2336)),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Create Account Button
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
                      onPressed: _handleSignUp,
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Forgot password / signup links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
