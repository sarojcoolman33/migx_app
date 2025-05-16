import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Screens import
import 'splash_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'home_screen.dart'; // Includes drawer + bottom tabs (Home | Chatrooms | Chatroom)
import 'inbox_screen.dart';
import 'announcements_screen.dart';
import 'feed_screen.dart';
import 'stores_screen.dart';
import 'mentor_screen.dart';
import 'settings_screen.dart';
import 'help_screen.dart';
import 'about_screen.dart';
import 'chatrooms_screen.dart';

// Optional: Chatroom screen (for dynamic opening)
import 'chatroom_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MigXApp());
}

class MigXApp extends StatelessWidget {
  const MigXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MigX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const MigXHomeScreen(), // Main screen with tabs & drawer
        '/inbox': (context) => const InboxScreen(),
        '/announcements': (context) => const AnnouncementsScreen(),
        '/feed': (context) => const FeedScreen(),
        '/stores': (context) => const StoresScreen(),
        '/mentor': (context) => const MentorScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/help': (context) => const HelpScreen(),
        '/about': (context) => const AboutScreen(),
        '/chatrooms': (context) => const ChatroomsScreen(),
        // ChatroomScreen is opened dynamically via Navigator.push
      },
    );
  }
}
