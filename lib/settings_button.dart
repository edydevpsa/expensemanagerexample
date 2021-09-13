import 'package:expensemanager/provider.dart';
import 'package:expensemanager/services/auth_service.dart';
import 'package:flutter/material.dart';
class Settings extends StatelessWidget {
  const Settings({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark ? 'DarkTheme' : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Settings $text', style: TextStyle(color: Colors.grey),),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.blueGrey,), 
            onPressed: (){
              //Navigator.of(context).pushReplacementNamed('/home');
              //Navigator.pop(context, [ '/home']);
              Navigator.of(context).popAndPushNamed('/home');
            }
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Convert Anonimous User a Permanet Google User
                // IconButton(
                //   icon: Icon(Icons.account_circle, size: 30.0,), 
                //   onPressed: (){
                //     Navigator.of(context).pushReplacementNamed('/converUser');
                //   }
                // ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.blueGrey[300],
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left: 20.0, right: 20.0),
                    child: Text('Sign Out', style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w300)),
                  ),
                  onPressed: ()async {
                    try {
                      AuthService auth = Provider.of(context).auth;
                      await auth.signOut();
                      print("Signed Out");
                    } catch (e) {
                      print(e);
                    }
                    Navigator.of(context).pushReplacementNamed('/home');  
                  },
                ),
                // FlatButton(
                //   child: Text(' Sign Out'),
                //   onPressed: () async{
                //     try {
                //       AuthService auth = Provider.of(context).auth;
                //       await auth.signOut();
                //       print("Signed Out");
                //     } catch (e) {
                //       print(e);
                //     }
                //     Navigator.of(context).pushReplacementNamed('/home');
                //   }, 
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}