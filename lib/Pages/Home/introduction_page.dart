import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Animations
  late Animation<double> _logoFade;
  late Animation<Offset> _logoSlide;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _buttonFade;
  late Animation<Offset> _buttonSlide;
  late Animation<double> _parallaxOffset; // parallax movement

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // LOGO animation
    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1, curve: Curves.easeOut),
    );
    _logoSlide = Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1, curve: Curves.easeOut),
      ),
    );

    // TEXT animation
    _textFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1, curve: Curves.easeOut),
      ),
    );

    // BUTTON animation
    _buttonFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );
    _buttonSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    // PARALLAX effect - moves image up by 20px
    _parallaxOffset = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutQuad),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Background with extra height to accommodate parallax movement
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(0, _parallaxOffset.value + 20),
                  child: SizedBox(
                    width: screenSize.width,
                    height: screenSize.height, // Add 40px (20px buffer on each side)
                    child: Image.asset(
                      'assets/images/intro_bg.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.center, // Center alignment for balanced movement
                    ),
                  ),
                ),
              ),

              // Overlay for better text contrast
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent, // fully transparent at top
                        Color.fromARGB(180, 0, 0, 0), // medium fade near bottom
                        Color.fromARGB(230, 0, 0, 0), // stronger black at very bottom
                      ],
                      stops: [0.5, 0.7, 1.0], // adjust fade distribution
                    ),
                  ),
                ),
              ),

              // Foreground content
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(), // Empty container to push content to bottom

                    Column(
                      children: [
                        // LOGO
                        FadeTransition(
                          opacity: _logoFade,
                          child: SlideTransition(
                            position: _logoSlide,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Center(child: Image.asset('assets/images/logo2.png', height: 75)),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        // TEXT (closer to button)
                        FadeTransition(
                          opacity: _textFade,
                          child: SlideTransition(
                            position: _textSlide,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Column(
                                children: const [
                                  Text(
                                    'Secure Business Chat',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'End-to-end secure business chat for financial professionals. Communicate with confidence.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 60),

                        // BUTTON
                        FadeTransition(
                          opacity: _buttonFade,
                          child: SlideTransition(
                            position: _buttonSlide,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                              child: SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await Navigator.pushNamed(context, '/signin');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF1B2336), //, // Haulr Red
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                                    elevation: 5,
                                    shadowColor: Colors.black45,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Get Started',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      const Icon(Icons.chevron_right_rounded, size: 24, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
