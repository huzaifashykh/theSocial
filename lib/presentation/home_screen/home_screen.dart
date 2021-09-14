import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/constant_colors.dart';
import 'package:the_social/presentation/chat_screen/chat_screen.dart';
import 'package:the_social/presentation/feed_screen/feed_screen.dart';
import 'package:the_social/presentation/home_screen/home_helper.dart';
import 'package:the_social/presentation/profile_screen/profile_screen.dart';
import 'package:the_social/services/firebase_operations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConstantColors constantColors = ConstantColors();
  final PageController homeScreenController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false).getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: PageView(
        controller: homeScreenController,
        children: [FeedScreen(), ChatScreen(), ProfileScreen()],
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            pageIndex = page;
          });
        },
      ),
      bottomNavigationBar:
          Provider.of<HomeHelper>(context, listen: false).bottomNavBar(context, pageIndex, homeScreenController),
    );
  }
}
