import 'package:acespeak/STUDENT/FEATURE/game/spelling.dart';
import 'package:acespeak/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'STUDENT/FEATURE/game/findobject.dart';
import 'STUDENT/FEATURE/quiz/list_quiz_screen.dart';
import 'STUDENT/MAIN FEATURE/LESSONS/video.dart';
import '0LD_CODE_TEACHER/QUIZ/teacher_quiz_section.dart';
import 'firebase_options.dart';
import 'user/welcome_page_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
   );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: HomeScreen(),),
      ),
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: EasyLoading.init(),
    );
  }
}
