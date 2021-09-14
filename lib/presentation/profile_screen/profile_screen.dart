import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/constant_colors.dart';
import 'package:the_social/presentation/profile_screen/profile_helper.dart';
import 'package:the_social/services/authentication.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constantColors.blueGreyColor.withOpacity(0.4),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ProfileHelper>(context, listen: false).logOutDialog(context);
            },
            icon: Icon(
              EvaIcons.logOutOutline,
              color: constantColors.greenColor,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            EvaIcons.settings2Outline,
            color: constantColors.lightBlueColor,
          ),
        ),
        title: RichText(
          text: TextSpan(
            text: "My ",
            style: TextStyle(
              fontFamily: "Poppins",
              color: ConstantColors().whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            children: [
              TextSpan(
                text: "Profile",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: ConstantColors().blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(Provider.of<Authentication>(context, listen: false).getUid)
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return new Column(
                    children: [
                      Provider.of<ProfileHelper>(context, listen: false).headerProfile(context, snapshots),
                      Provider.of<ProfileHelper>(context, listen: false).divider(),
                      Provider.of<ProfileHelper>(context, listen: false).middleProfile(context, snapshots),
                      Provider.of<ProfileHelper>(context, listen: false).footerProfile(context, snapshots),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
