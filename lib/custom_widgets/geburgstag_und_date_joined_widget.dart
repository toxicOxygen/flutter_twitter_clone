import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class DateOfBirthAndDateJoinedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;
    return Row(
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
    );
  }
}
