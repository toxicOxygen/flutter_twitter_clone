import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../pages/welcome_page.dart';
import '../providers/auth_providers.dart';
import '../pages/profile_page.dart';

class SideBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          elevation: 1,
          title: Text('Account info',style: TextStyle(color: Colors.black),),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: ()=>Navigator.of(context).pop(),
            )
          ],
        ),
        ListTile(
          leading: CircleAvatar(
            minRadius: 20,
            maxRadius: 25,
            backgroundImage: NetworkImage('https://tinyurl.com/yakkyll3'),
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_circle_outline,color: Colors.blue,size: 40,),
            onPressed: (){},
          ),
        ),
        SizedBox(height: 5,),
        Container(
          padding: const EdgeInsets.only(left: 18),
          width: double.infinity,
          child: Text('Baffour Kusi',style: TextStyle(fontWeight: FontWeight.bold),)
        ),
        Container(
          padding: const EdgeInsets.only(left: 18),
          width: double.infinity,
          child: Text('@MOBZ',style: TextStyle(color: Colors.black45),)
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18,top: 10),
          child: Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                  text: '101 ',
                  children: [
                    TextSpan(
                      text: 'Following',
                      style: TextStyle(color: Colors.black45)
                    )
                  ]
                ),
              ),
              SizedBox(width: 20,),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                  text: '11 ',
                  children: [
                    TextSpan(
                      text: 'Followers',
                      style: TextStyle(color: Colors.black45)
                    )
                  ]
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.perm_identity),
          title: Text('Profile'),
          onTap: (){
            final provider = Provider.of<UserProvider>(context,listen: false);
            Navigator.of(context).popAndPushNamed(
              ProfilePage.tag,
              arguments: provider.currentUser
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.lock_open),
          title: Text('Change Password'),
          onTap: (){},
        ),
        Expanded(child: Container(),),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: (){
            final auth = Provider.of<AuthProvider>(context,listen: false);
            auth.logout().then((value){
              if(value){
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(WelcomePage.tag);
              }
            }).catchError((e){
              print(e);
            });
          },
        )
      ],
    );
  }
}
