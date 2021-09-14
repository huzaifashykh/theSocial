import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/constant_colors.dart';

import 'package:flutter/material.dart';
import 'package:the_social/services/firebase_operations.dart';

class HomeHelper extends ChangeNotifier {
  ConstantColors constantColors = ConstantColors();

  Widget bottomNavBar(BuildContext context, int index, PageController pageController) {
    return CustomNavigationBar(
      currentIndex: index,
      bubbleCurve: Curves.bounceIn,
      scaleCurve: Curves.decelerate,
      selectedColor: constantColors.blueColor,
      unSelectedColor: constantColors.whiteColor,
      strokeColor: constantColors.blueColor,
      scaleFactor: 0.5,
      iconSize: 30.0,
      onTap: (val) {
        index = val;
        pageController.jumpToPage(val);
        notifyListeners();
      },
      backgroundColor: Color(0xff040307),
      items: [
        CustomNavigationBarItem(icon: Icon(EvaIcons.home)),
        CustomNavigationBarItem(icon: Icon(Icons.message_rounded)),
        CustomNavigationBarItem(
            icon: CircleAvatar(
          radius: 35.0,
          backgroundColor: constantColors.whiteColor,
          // ignore: unnecessary_null_comparison
          backgroundImage: Provider.of<FirebaseOperations>(context, listen: false).getInitUserImage == null
              ? null
              : NetworkImage(Provider.of<FirebaseOperations>(context, listen: false).getInitUserImage),
        )),
      ],
    );
  }
}
