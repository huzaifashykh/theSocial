import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/constant_colors.dart';
import 'package:the_social/presentation/feed_screen/feed_helper.dart';
import 'package:the_social/presentation/home_screen/home_helper.dart';
import 'package:the_social/presentation/landing_screen/landing_helper.dart';
import 'package:the_social/presentation/landing_screen/landing_services.dart';
import 'package:the_social/presentation/landing_screen/landing_utils.dart';
import 'package:the_social/presentation/profile_screen/profile_helper.dart';
import 'package:the_social/presentation/splash_screen/splash_screen.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/services/firebase_operations.dart';
import 'package:the_social/utils/upload_post.dart';

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
        ChangeNotifierProvider(create: (_) => FeedHelper()),
        ChangeNotifierProvider(create: (_) => UploadPost()),
        ChangeNotifierProvider(create: (_) => ProfileHelper()),
        ChangeNotifierProvider(create: (_) => HomeHelper()),
        ChangeNotifierProvider(create: (_) => FirebaseOperations()),
        ChangeNotifierProvider(create: (_) => LandingUtils()),
        ChangeNotifierProvider(create: (_) => LandingServices()),
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => LandingHelper()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // ignore: deprecated_member_use
          accentColor: ConstantColors().blueColor,
          fontFamily: "Poppins",
          canvasColor: Colors.transparent,
          brightness: Brightness.dark,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
