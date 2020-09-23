import 'package:flutter/material.dart';
import '../pages/root_screen.dart';
import '../providers/auth_providers.dart';
import '../extras/validators.dart';
import '../custom_widgets/loading_widget.dart';
import './welcome_page.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static String tag = 'sign-up-page';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _authData = {'email':'','password':'','username':''};

  String _password = '';
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: FlutterLogo(size: 20,),
        iconTheme: IconThemeData(color: Colors.blue),
      ),

      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Text(
                  'Create your account',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
              Expanded(child: Container(),flex: 2,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: UnderlineInputBorder(),
                        ),
                        maxLength: 50,
                        onSaved: (val)=>_authData['username']=val,
                        validator: (val)=> isUsernameValid(val),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: UnderlineInputBorder()
                        ),
                        onSaved: (val)=> _authData['email']=val,
                        validator: (val)=> isEmailValid(val),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: UnderlineInputBorder()
                        ),
                        onSaved: (val)=> _authData['password'] = val,
                        validator: (val)=> isPasswordValid(val),
                        onChanged: (val)=> _password = val,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: UnderlineInputBorder()
                        ),
                        validator: (val){
                          if(val != _password)
                            return "passwords do not match";
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container(),flex: 3,),
              Divider(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 40,
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Create Account'),
                  onPressed: ()=> _signUp(context),
                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
          if(_isLoading)
            LoadingScreenWidget(),
        ],
      ),
    );
  }

  void _signUp(BuildContext context) async{
    if(!_formKey.currentState.validate())
      return;
    _formKey.currentState.save();
    setState(() {_isLoading = true ; });

    final auth = Provider.of<AuthProvider>(context,listen: false);
    auth.signUp(
        _authData['email'],
        _authData['username'],
        _authData['password']
    ).then((value){
      setState(() {_isLoading = false; });
      Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
      Navigator.of(context).pushReplacementNamed(RootScreen.tag);
    }).catchError((er){
      setState(() {_isLoading = false; });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('$er'),
        duration: Duration(milliseconds: 1500),
      ));
    });

  }
}
