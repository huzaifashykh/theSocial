import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/presentation/landing_screen/landing_utils.dart';
import 'package:the_social/services/authentication.dart';

class FirebaseOperations extends ChangeNotifier {
  late UploadTask imageUploadTask;
  late String initUserName, initUserEmail, initUserImage = "";

  String get getInitUserName => initUserName;
  String get getInitUserEmail => initUserEmail;
  String get getInitUserImage => initUserImage;

  Future uploadUserAvatar(BuildContext context) async {
    Reference imageRef = FirebaseStorage.instance
        .ref()
        .child("userAvatar/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}");
    imageUploadTask = imageRef.putFile(Provider.of<LandingUtils>(context, listen: false).getUserAvatar);

    await imageUploadTask.whenComplete(() {
      print("Image Uploaded!");
    });

    await imageRef.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl = url.toString();
      print("user avatar url ${Provider.of<LandingUtils>(context, listen: false).getUserAvatarUrl}");
      notifyListeners();
    });
  }

  Future uploadUserData(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(Provider.of<Authentication>(context, listen: false).getUid)
        .set(data);
  }

  Future getUserData(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(Provider.of<Authentication>(context, listen: false).getUid)
        .get()
        .then((doc) {
      print("Fetching Data!");
      initUserEmail = doc.data()!["userEmail"];
      initUserImage = doc.data()!["userImage"];
      initUserName = doc.data()!["userName"];

      print(initUserName);
      print(initUserEmail);
      print(initUserImage);

      notifyListeners();
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection("posts").doc(postId).set(data);
  }
}
