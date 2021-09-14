import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/constant_colors.dart';
import 'package:the_social/presentation/home_screen/home_screen.dart';
import 'package:the_social/presentation/landing_screen/landing_utils.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/services/firebase_operations.dart';
import 'package:the_social/widgets/custom_text_field.dart';

class LandingServices extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ConstantColors constantColors = ConstantColors();

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.32,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: constantColors.blueGreyColor,
            borderRadius: BorderRadius.circular(15.0),
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
              CircleAvatar(
                radius: 80.0,
                backgroundColor: constantColors.transperant,
                backgroundImage: FileImage(Provider.of<LandingUtils>(context, listen: false).userAvatar),
              ),
              SizedBox(height: 10.0),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Provider.of<LandingUtils>(context, listen: false).selectAvatarOptionSheet(context);
                      },
                      child: Text(
                        "Reselect",
                        style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: constantColors.whiteColor,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Provider.of<FirebaseOperations>(context, listen: false)
                            .uploadUserAvatar(context)
                            .whenComplete(() {
                          Navigator.pop(context);
                          signUpSheet(context);
                        });
                      },
                      child: Text(
                        "Confirm Image",
                        style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: constantColors.blueColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  signUpSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
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
                CircleAvatar(
                  backgroundColor: constantColors.redColor,
                  backgroundImage: FileImage(Provider.of<LandingUtils>(context, listen: false).getUserAvatar),
                  radius: 80.0,
                ),
                CustomTextField(
                  textEditingController: userNameController,
                  hintText: "Enter Name",
                ),
                CustomTextField(
                  textEditingController: emailController,
                  hintText: "Enter Email",
                ),
                CustomTextField(
                  textEditingController: passwordController,
                  hintText: "Enter Password",
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          userNameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        Provider.of<Authentication>(context, listen: false)
                            .signUp(emailController.text, passwordController.text)
                            .whenComplete(() {
                          Provider.of<FirebaseOperations>(context, listen: false).uploadUserData(context, {
                            "userUid": Provider.of<Authentication>(context, listen: false).getUid,
                            "userName": userNameController.text,
                            "userEmail": emailController.text,
                            "userImage": Provider.of<LandingUtils>(context, listen: false).getUserAvatarUrl,
                          });
                        }).whenComplete(() {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: HomeScreen(),
                              type: PageTransitionType.leftToRight,
                            ),
                          );
                        });
                      } else {
                        warningText(context, "Fill all the fields!");
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.check,
                      color: constantColors.whiteColor,
                    ),
                    backgroundColor: constantColors.redColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  signInSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
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
                CustomTextField(
                  textEditingController: emailController,
                  hintText: "Enter Email",
                ),
                CustomTextField(
                  textEditingController: passwordController,
                  hintText: "Enter Password",
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                        Provider.of<Authentication>(context, listen: false)
                            .signIn(emailController.text, passwordController.text)
                            .whenComplete(() {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: HomeScreen(),
                              type: PageTransitionType.leftToRight,
                            ),
                          );
                        });
                      } else {
                        warningText(context, "Fill all the fields!");
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.check,
                      color: constantColors.whiteColor,
                    ),
                    backgroundColor: constantColors.blueColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: constantColors.redColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              warning,
              style: TextStyle(
                color: constantColors.whiteColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
