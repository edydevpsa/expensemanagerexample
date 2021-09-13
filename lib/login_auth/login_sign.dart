import 'package:auth_buttons/auth_buttons.dart';
import 'package:auth_buttons/res/buttons/google_auth_button.dart';
import 'package:expensemanager/provider.dart';
import 'package:expensemanager/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum AuthFormType{signIn, signUp, resetPassword, anonymousUser,}

class LoginSign extends StatefulWidget {

  final AuthFormType authFormType;
  LoginSign({ Key key, @required this.authFormType }) : super(key: key); //Constructor

  @override
  _LoginSignState createState() => _LoginSignState(authFormType: this.authFormType);
}

class _LoginSignState extends State<LoginSign> {
  AuthFormType authFormType;
  final formKey = GlobalKey<FormState>();
  String _email, _password, _name, _warning;
  bool _showAppleSign = false;

  _LoginSignState({this.authFormType}); //Constructor

  void switchFormState(String state){
    formKey.currentState.reset();
    if (state == 'signUp') {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    }else{
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }
  
  bool validate(){
    final form = formKey.currentState;
    form.save();
    if(form.validate()) {
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void submit() async{
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        switch (authFormType) {
          case AuthFormType.signIn:
            await auth.signInWitnEmailandPassword(_email, _password);
            //print("Signed In with ID $uid");
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.signUp:
            await auth.createUserWithEmailandPassword(_email, _password, _name);
            //print("Signed Up new User with ID $uid");
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.resetPassword:
            await auth.sendpasswordResetEmail(_email);
            print('paswword reset email send');
            _warning = 'a password resent link has been sent to $_email';
            setState(() {
              authFormType = AuthFormType.signIn;
            });
            break;
          default:
        }
  
        // if (authFormType == AuthFormType.signIn) {
        //   String uid = await auth.signInWitnEmailandPassword(_email, _password);
        //   print("Signed In with ID $uid");
        //   Navigator.of(context).pushReplacementNamed('/home');
        // }else if(authFormType == AuthFormType.resetPassword){
        //   await auth.sendpasswordResetEmail(_email);
        //   print('paswword reset email send');
        //   _warning = 'a password resent link has been sent to $_email';
        //   setState(() {
        //     authFormType = AuthFormType.signIn;
        //   });
        // }else{
        //   String uid = await auth.createUserWithEmailandPassword(_email, _password, _name);
        //   print("Signed Up new User with ID $uid");
        //   Navigator.of(context).pushReplacementNamed('/home');
        // }
      }catch (e) {
        setState(() {
          print(e);
          //_error = e.nativeErrorMessage;
          _warning = e.message;
        });
      }
    }
  }
  Future submitAnonimously()async{
    final auth = Provider.of(context).auth;
    await auth.signInAnonimously();

    Navigator.of(context).pushReplacementNamed('/home'); 
  }

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if (authFormType == AuthFormType.anonymousUser) {
      submitAnonimously();
      return Scaffold(
        backgroundColor: Colors.pink[400],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFoldingCube(color:  Colors.white,),
            SizedBox(height: 10.0,),
            Text('Loading...', style:TextStyle(color: Colors.white, fontSize: 16.0)),
          ],
        ),
      );

    } else {

      return Scaffold( 
        body: Container(
          color: Colors.deepPurple[300],
          height: _height,
          width: _width,
          child: SafeArea(
            child: SingleChildScrollView(
                          child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: _height* 0.05,),
                    showAlert(),
                     SizedBox(height: _height* 0.05,),
                    buildHeaderText(),
                    SizedBox(height: _height* 0.05,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: buildImputs() + buildInputButtons(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    
  }

  //show Alert Dialog error user, email and Password
  Widget showAlert(){
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: Text(_warning, maxLines: 3,)),
            IconButton(
              icon: Icon(Icons.close), 
              onPressed: (){
                setState(() {
                  _warning = null;
                });
              }
            ),
          ],
        ),
      );
    }
    return SizedBox(height: 0.0,);
  }

  //header text
  Text buildHeaderText(){
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = 'Create New Account';
    }else if(authFormType == AuthFormType.resetPassword){
      _headerText = 'Reset Password';
    }else{
      _headerText = 'Sign In';
    }
    return Text(
      _headerText,
      maxLines: 1,
      style:  TextStyle(color: Colors.white,fontSize: 35.0,),
    );
  }
  List<Widget> buildImputs() {
    List<Widget> textFields = [];
    //if were in the Sig Up state add name

    if (authFormType == AuthFormType.resetPassword) {
      textFields.add(
        TextFormField(validator: EmailValidator.validate,
          style: TextStyle(fontSize: 20.0),
          decoration: buildSignUpInputDecoration('Email', Icon(Icons.email)),
          onSaved: (newValue) => _name = newValue,
        ),
      );
      textFields.add(SizedBox(height: 20.0));
      return textFields;
    }
    if (authFormType == AuthFormType.signUp) {
      textFields.add(
        TextFormField(validator: NameValidator.validate,
          style: TextStyle(fontSize: 20.0),
          decoration: buildSignUpInputDecoration('Name', Icon(Icons.account_circle)),
          onSaved: (newValue) => _email = newValue,
        ),
      );
    }
    textFields.add(SizedBox(height: 25.0));

    //add email and password

    textFields.add(
      TextFormField(
        validator: EmailValidator.validate,
        style: TextStyle(fontSize: 20.0),
        decoration: buildSignUpInputDecoration('Email',Icon(Icons.email)),
        onSaved: (newValue) => _email = newValue,
      ),
    );
    textFields.add(SizedBox(height: 20.0,));
    textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        style: TextStyle(fontSize: 20.0),
        decoration: buildSignUpInputDecoration('Password', Icon(Icons.vpn_key)),
        obscureText: true,
        onSaved: (newValue) => _password = newValue,
      ),
    );

    textFields.add(SizedBox(height: 20.0));

    return textFields;

  }

  List<Widget>buildInputButtons(){
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;
    bool _showSocial = true;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = 'Create new Account';
      _newFormState = 'signUp';
      _submitButtonText = 'Sign In';
      _showForgotPassword = true;
    }else if(authFormType == AuthFormType.resetPassword){
      _switchButtonText = 'Return to Sign In';
      _newFormState = 'signIn';
      _submitButtonText = 'Submit';
      _showSocial = false;
    }else{
      _switchButtonText = ' have an Account?  Sign In';
      _newFormState = 'signIn';
      _submitButtonText = 'Sign Up';
    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: RaisedButton(
          color: Colors.white70,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_submitButtonText, style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),),
          ),
          onPressed: submit //methodo void submit()//;
        ),
      ),
      showForgotpassword(_showForgotPassword),
      FlatButton(
        child: Text(_switchButtonText, style: TextStyle(color: Colors.white, fontSize: 18.0),),
        onPressed: (){
          switchFormState(_newFormState);
        }, 
      ),
      buildsocialIcons(_showSocial),
    ];

  }

  InputDecoration buildSignUpInputDecoration(String hint, Icon icons){
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white12,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      prefixIcon: icons,
    );
  }
  
  Widget showForgotpassword(bool visible){
    return Visibility(
      child: FlatButton( 
        child: Text('Forgot Password?', style: TextStyle(color: Colors.white, fontSize: 16.0)),
        onPressed: (){
          setState(() {
            authFormType = AuthFormType.resetPassword;
          });
        },
      ),
      visible: visible,
    );
  }

  Widget buildsocialIcons(bool visible){
    final _auth = Provider.of(context).auth;
    return Visibility(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Divider(color:  Colors.white,),
          SizedBox(height: 20.0,),
          GoogleAuthButton(
            onPressed: () async{
              try {
                await _auth.signInWithGoogle();
                print(_auth);
                Navigator.of(context).pushReplacementNamed('/home');
              } catch (e) {
                print(e);
                _warning = e.message;
              }
            }
          ),
          SizedBox(height: 20.0,),
          
          buildAppleSignIn(_auth),
        ],
      ),
      visible: visible,
    );
  }
  // String validatetor(String value){
  //   if (value.isEmpty) {
  //     return Text('Email can\'t be empty', style: TextStyle(color: Colors.amber),);
  //   }
  //   return null;
  // }

  Widget buildAppleSignIn( AuthService _auth){
    if (authFormType == AuthFormType.signIn) {
      return AppleAuthButton(
        onPressed: ()async{
          await _auth.signInWithApple();
          //print('Sign in with Apple');
          Navigator.of(context).pushReplacementNamed('/home');
        },
        darkMode: true,
        width: 260.0,
      );
    }else{
      return Container();
    }

    // return AppleAuthButton(
    //     onPressed: ()async{
    //       await _auth.signInWithApple();
    //       //print('Sign in with Apple');
    //       Navigator.of(context).pushReplacementNamed('/home');
    //     },
    //     darkMode: true,
    //     width: 260.0,
    //   );
  }
}