import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/constant_colors.dart';
import 'package:the_social/presentation/home_screen/home_screen.dart';
import 'package:the_social/presentation/landing_screen/landing_services.dart';
import 'package:the_social/presentation/landing_screen/landing_utils.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/widgets/social_btn.dart';

class LandingHelper extends ChangeNotifier {
  ConstantColors constantColors = ConstantColors();

  Widget bodyImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login.png"),
        ),
      ),
    );
  }

  Widget tagLineText(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          text: "Are ",
          style: TextStyle(
            fontFamily: "Poppins",
            color: constantColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
          children: [
            TextSpan(
              text: "You ",
              style: TextStyle(
                fontFamily: "Poppins",
                color: constantColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            TextSpan(
              text: "Social ",
              style: TextStyle(
                fontFamily: "Poppins",
                color: constantColors.blueColor,
                fontWeight: FontWeight.bold,
                fontSize: 34.0,
              ),
            ),
            TextSpan(
              text: "? ",
              style: TextStyle(
                fontFamily: "Poppins",
                color: constantColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 34.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                emailAuthSheet(context);
              },
              child: SocialBtn(
                color: constantColors.yellowColor,
                icon: Icon(
                  EvaIcons.emailOutline,
                  color: constantColors.yellowColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Provider.of<Authentication>(context, listen: false).signUpWithGoogle().whenComplete(() {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: HomeScreen(),
                      type: PageTransitionType.leftToRight,
                    ),
                  );
                });
              },
              child: SocialBtn(
                color: constantColors.redColor,
                icon: Icon(
                  FontAwesomeIcons.google,
                  color: constantColors.redColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget privacyText(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "By continuing you agree theSocial's Terms of",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12.0,
            ),
          ),
          Text(
            "Services & Privacy Policy",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12.0,
            ),
          )
        ],
      ),
    );
  }

  emailAuthSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: constantColors.blueGreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 4.0,
                  color: constantColors.whiteColor,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Provider.of<LandingServices>(context, listen: false).signInSheet(context);
                    },
                    color: constantColors.blueColor,
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: constantColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Provider.of<LandingUtils>(context, listen: false).selectAvatarOptionSheet(context);
                    },
                    color: constantColors.redColor,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: constantColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
