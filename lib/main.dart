import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logos_messenger/Pages/Security/verify_page.dart';
import 'util.dart';
import 'theme.dart';
import 'package:logos_messenger/Pages/Conversations/conversations_page.dart';
import 'package:logos_messenger/Pages/Home/introduction_page.dart';
import 'package:logos_messenger/Pages/Security/signin_page.dart';
import 'package:logos_messenger/Pages/Security/signup_page.dart';
import 'package:logos_messenger/Services/Security/key_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: "assets/secrets.env");

  // Initialize KeyService and ensure key pair exists
  final keyService = KeyService();
  await keyService.getPublicKeyBase64();

  runApp(const LogosApp());
}

class LogosApp extends StatelessWidget {
  const LogosApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Lato", "Lato");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Logos Messenger',
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routes: {
        '/introduction': (context) => const IntroductionPage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/conversations': (context) => const ConversationsPage(),
        '/verify': (context) => const VerifyPage(),
      },
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
          case '/introduction':
            return _buildFadeSlideRoute(const IntroductionPage(), settings);
          case '/signin':
            return _buildFadeSlideRoute(const SignInPage(), settings);
          case '/signup':
            return _buildFadeSlideRoute(const SignUpPage(), settings);
          case '/conversations':
            return _buildFadeSlideRoute(const ConversationsPage(), settings);
          case '/verify':
            return _buildFadeSlideRoute(const VerifyPage(), settings);
          default:
            return _buildFadeRoute(const IntroductionPage(), settings);
        }
      },
    );
  }

  // Fade Transition
  PageRouteBuilder _buildFadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 600),
    );
  }

  // Fade + Slide Transition (for premium navigation)
  PageRouteBuilder _buildFadeSlideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(0.0, 0.1); // slight upward slide
        const end = Offset.zero;
        final curve = Curves.easeOutQuad;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: animation.drive(tween), child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
    );
  }
}
