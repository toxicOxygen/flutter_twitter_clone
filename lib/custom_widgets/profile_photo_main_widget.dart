import 'package:flutter/material.dart';
import '../models/users.dart';
import './profile_photo_widget.dart';

class ProfilePhotoMainWidget extends StatelessWidget {
  final User user;

  ProfilePhotoMainWidget({
    this.user,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        ProfilePhotoWidget(user:user),
        Container(
            padding: const EdgeInsets.only(left: 18,top: 10),
            width: double.infinity,
            child: Text(user.username,style: TextStyle(fontWeight: FontWeight.bold),)
        ),
        Container(
            padding: const EdgeInsets.only(left: 18),
            width: double.infinity,
            child: Text(
              '@bk_${user.username}',
              style: TextStyle(color: Colors.black54),
            )
        ),
        if(user.bio.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
            width: double.infinity,
            child: Text(
              "${user.bio}",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left:18.0,top: 10,right: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if(user.dateOfBirth != null && user.dateOfBirth.isNotEmpty)
                Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.cake,color: Colors.black54,),
                  Text(
                    ' Born February 29,1996',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              if(user.dateOfBirth != null && user.dateOfBirth.isNotEmpty)
                SizedBox(width: 15,),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.calendar_today,color: Colors.black54,),
                  Text(
                    ' Joined August 2011',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left:18.0,right: 18,top: 10),
          child: Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                    text: '101 ',
                    children: [
                      TextSpan(
                          text: 'Following',
                          style: TextStyle(color: Colors.black45,fontWeight: FontWeight.normal)
                      )
                    ]
                ),
              ),
              SizedBox(width: 15,),
              RichText(
                text: TextSpan(
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                    text: '11 ',
                    children: [
                      TextSpan(
                          text: 'Followers',
                          style: TextStyle(color: Colors.black45,fontWeight: FontWeight.normal)
                      )
                    ]
                ),
              ),

            ],
          ),
        )
      ],
    );
  }
}
