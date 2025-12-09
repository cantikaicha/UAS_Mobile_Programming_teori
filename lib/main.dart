import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage/HomePage.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  String imagepath = sp.getString('imagepath') ?? '';

  runApp(MyApp(imagepath: imagepath));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String imagepath;
  MyApp({
    super.key,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntermediateScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}

class IntermediateScreen extends StatefulWidget {
  const IntermediateScreen({super.key});

  @override
  State<IntermediateScreen> createState() => _IntermediateScreenState();
}

class _IntermediateScreenState extends State<IntermediateScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      duration: 2000,
      nextScreen: const LoginScreen(), // setelah splash -> login
      splash: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/icon.png'),
                        fit: BoxFit.contain)),
              ),
            ),
            const Expanded(
              child: Text(
                'By Cantika Studio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 200,
    );
  }
}
