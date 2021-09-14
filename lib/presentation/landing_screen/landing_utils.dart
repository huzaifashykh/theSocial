import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_social/presentation/landing_screen/landing_services.dart';
import 'package:the_social/constants/constant_colors.dart';

class LandingUtils extends ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  final ImagePicker imagePicker = ImagePicker();
  late File userAvatar;
  late String userAvatarUrl;

  File get getUserAvatar => userAvatar;
  String get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await imagePicker.pickImage(source: source);
    pickedUserAvatar == null ? print("Select Image Please!") : userAvatar = File(pickedUserAvatar.path);
    // print(userAvatar.path);

    // ignore: unnecessary_null_comparison
    userAvatar != null
        ? Provider.of<LandingServices>(context, listen: false).showUserAvatar(context)
        : print("Image Upload Error!");

    notifyListeners();
  }

  Future selectAvatarOptionSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
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
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      pickUserAvatar(context, ImageSource.camera).whenComplete(() {
                        Navigator.pop(context);
                        Provider.of<LandingServices>(context, listen: false).showUserAvatar(context);
                      });
                    },
                    child: Text(
                      "Camera",
                      style: TextStyle(
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    color: constantColors.blueColor,
                  ),
                  MaterialButton(
                    onPressed: () {
                      pickUserAvatar(context, ImageSource.gallery).whenComplete(() {
                        Navigator.pop(context);
                        Provider.of<LandingServices>(context, listen: false).showUserAvatar(context);
                      });
                    },
                    child: Text(
                      "Gallery",
                      style: TextStyle(
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    color: constantColors.blueColor,
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
