import 'package:book_time/screens/contact_us/contacts.dart';
import 'package:book_time/screens/homepage/homepage.dart';
import 'package:book_time/screens/mybooks/mybooks.dart';
import 'package:book_time/screens/profile/profile.dart';
import 'package:book_time/screens/signup/signup.dart';
import 'package:book_time/screens/test/test.dart';
import 'package:book_time/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:book_time/screens/login/login.dart';
import 'package:book_time/utils/great_theme.dart';
import 'package:book_time/screens/explore/explore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:book_time/screens/settings/settings.dart';
import 'package:book_time/screens/faq/faq.dart';
import 'package:book_time/screens/specificbook/specificbook.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/homepage': (context) => HomePage(),
          '/explore': (context) => ExplorePage(),
          '/settings': (context) => SettingsPage(),
          '/faq': (context) => FaqPage(),
          '/profile': (context) => ProfilePage(),
          '/contacts': (context) => ContactsPage(),
          '/mybooks': (context) => MyBooksPage(),
          '/specificbook': (context) => SpecificBookPage(),
          '/testpage': (context) => TestPage(),
        },
        debugShowCheckedModeBanner: false,
        theme: GreatTheme().buildTheme(),
        home: FirebaseAuth.instance.currentUser == null
            ? LoginPage()
            : HomePage(),
      ),
    );
  }
}
