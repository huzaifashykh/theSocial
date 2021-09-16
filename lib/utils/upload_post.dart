import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/constant_colors.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/services/firebase_operations.dart';

class UploadPost extends ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  final imagePicker = ImagePicker();
  TextEditingController captionController = TextEditingController();

  late File uploadPostImage;
  late String uploadPostImageUrl;
  late UploadTask uploadTask;

  File get getUploadPostImage => uploadPostImage;
  String get getUploadPostImageUrl => uploadPostImageUrl;

  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final uploadPostImageVal = await imagePicker.pickImage(source: source);
    uploadPostImageVal == null ? print("Select Image Please!") : uploadPostImage = File(uploadPostImageVal.path);
    // print(uploadPostImageVal!.path);

    // ignore: unnecessary_null_comparison
    uploadPostImage != null ? showPostImage(context) : print("Image Upload Error!");

    notifyListeners();
  }

  Future uploadPostImageToFirebase() async {
    Reference imageRef = FirebaseStorage.instance.ref().child(
          "posts/${uploadPostImage.path}/${TimeOfDay.now()}",
        );
    uploadTask = imageRef.putFile(uploadPostImage);
    await uploadTask.whenComplete(() {
      print("Post IMG Upload Successfully!");
    });
    imageRef.getDownloadURL().then((imgUrl) {
      uploadPostImageUrl = imgUrl;
      print(uploadPostImageUrl);
    });
    notifyListeners();
  }

  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: constantColors.blueGreyColor,
            borderRadius: BorderRadius.circular(12.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      pickUploadPostImage(context, ImageSource.gallery);
                    },
                    color: constantColors.blueColor,
                    child: Text(
                      "Gallery",
                      style: TextStyle(
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      pickUploadPostImage(context, ImageSource.camera);
                    },
                    color: constantColors.blueColor,
                    child: Text(
                      "Camera",
                      style: TextStyle(
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  showPostImage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.39,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: constantColors.darkColor,
            borderRadius: BorderRadius.circular(12.0),
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Container(
                  height: 200.0,
                  width: 400.0,
                  child: Image.file(
                    uploadPostImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        selectPostImageType(context);
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
                        uploadPostImageToFirebase().whenComplete(() {
                          editPostSheet(context);
                          print("Image Uploaded!");
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

  editPostSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(12.0),
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
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.image_aspect_ratio,
                                color: constantColors.greenColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.fit_screen,
                                color: constantColors.yellowColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200.0,
                        width: 300.0,
                        child: Image.file(
                          uploadPostImage,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: Image.asset("assets/icons/sunflower.png"),
                      ),
                      Container(
                        height: 110.0,
                        width: 5.0,
                        color: constantColors.blueColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 120.0,
                          width: 330.0,
                          child: TextField(
                            // ignore: deprecated_member_use
                            maxLengthEnforced: true,
                            controller: captionController,
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100),
                            ],
                            maxLength: 100,
                            style: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                                hintText: "Add a Caption",
                                hintStyle: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                    color: constantColors.blueColor,
                    onPressed: () async {
                      Provider.of<FirebaseOperations>(context, listen: false).uploadPostData(captionController.text, {
                        "postimage": getUploadPostImageUrl,
                        "caption": captionController.text,
                        "username": Provider.of<FirebaseOperations>(context, listen: false).getInitUserName,
                        "userimage": Provider.of<FirebaseOperations>(context, listen: false).getInitUserImage,
                        "useremail": Provider.of<FirebaseOperations>(context, listen: false).getInitUserEmail,
                        "useruid": Provider.of<Authentication>(context, listen: false).getUid,
                        "time": Timestamp.now(),
                      }).whenComplete(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      "Share",
                      style: TextStyle(
                        color: constantColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
