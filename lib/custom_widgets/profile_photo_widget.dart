import 'package:flutter/material.dart';
import 'package:twitter_clone/custom_widgets/cover_photo_widget.dart';
import 'package:twitter_clone/custom_widgets/user_profile_photo_widget.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../pages/edit_profile_page.dart';
import '../models/users.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final bool isEditable;
  final List<int> separation;
  final User user;

  ProfilePhotoWidget({
    this.isEditable = false,
    this.separation = const [1,6,1],
    this.user
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final currentUser = Provider.of<UserProvider>(context).currentUser;

    String btnTxt = '';
    if(!isEditable)
      btnTxt = user.id == currentUser.id ? "Edit Profile" : "Follow";

    return Stack(
      children: <Widget>[
        Container(
          height: height * 0.28,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: CoverPhotoWidget(isEditable: isEditable),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(flex: separation[0],child: Container(),),
              Container(
                height: 102,
                width: 102,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 2
                  )
                ),
                child: UserProfilePhotoWidget(isEditable: isEditable,),
              ),
              Expanded(flex: separation[1],child: Container(),),
              if(!isEditable)
                OutlineButton(
                  borderSide: BorderSide(color: Colors.blue,width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                  child: Text(
                    '$btnTxt',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  color: Colors.blue,
                  textColor: Colors.blue,
                  onPressed: (){
                    if(currentUser.id == user.id)
                      Navigator.of(context).pushNamed(EditProfilePage.tag);
                    else
                      print("run code to follow user");
                  },
                ),
              Expanded(flex: separation[2],child: Container(),),
            ],
          ),
        ),
      ],
    );
  }

}
