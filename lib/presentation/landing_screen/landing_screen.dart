import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/constant_colors.dart';
import 'package:the_social/presentation/landing_screen/landing_helper.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.whiteColor,
      body: Stack(
        children: [
          bodyColor(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Provider.of<LandingHelper>(context, listen: false).bodyImage(context),
              Provider.of<LandingHelper>(context, listen: false).tagLineText(context),
              Provider.of<LandingHelper>(context, listen: false).mainButton(context),
              Provider.of<LandingHelper>(context, listen: false).privacyText(context),
            ],
          )
        ],
      ),
    );
  }

  bodyColor() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.5,
            0.9,
          ],
          colors: [
            constantColors.darkColor,
            constantColors.blueGreyColor,
          ],
        ),
      ),
    );
  }
}
