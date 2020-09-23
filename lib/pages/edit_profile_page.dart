import 'package:flutter/material.dart';
import '../providers/user_provider.dart';
import '../custom_widgets/profile_photo_widget.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  static String tag = 'edit-profile-page';

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: (){},
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Save'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ProfilePhotoWidget(
              isEditable: true,
              separation: [1,10,1],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 15),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: currentUser.username,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        filled: true,
                        fillColor: Colors.black12
                      ),
                      maxLength: 50,
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      initialValue: currentUser.bio??'',
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        filled: true,
                        fillColor: Colors.black12
                      ),
                      maxLength: 160,
                      maxLines: 3,
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      initialValue: currentUser.location??'',
                      decoration: InputDecoration(
                        labelText: 'Location',
                        filled: true,
                        fillColor: Colors.black12
                      ),
                      maxLength: 30,
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      initialValue: currentUser.website??'',
                      decoration: InputDecoration(
                        labelText: 'Website',
                        filled: true,
                        fillColor: Colors.black12
                      ),
                      maxLength: 100,
                    ),
                    SizedBox(height: 8,),
                    Container(
                      width: double.infinity,
                      child: RichText(
                        text: TextSpan(
                          text: 'Birth date ',
                          style: TextStyle(color: Colors.black54),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Edit',
                              style: TextStyle(color: Colors.blue)
                            )
                          ]
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Add your date of birth',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.black87
                        ),
                      )
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
