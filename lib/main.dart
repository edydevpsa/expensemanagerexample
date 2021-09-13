import 'package:expensemanager/login_auth/first_view.dart';
import 'package:expensemanager/login_auth/login_sign.dart';
import 'package:expensemanager/pages/add_page.dart';
import 'package:expensemanager/pages/details_page.dart';
import 'package:expensemanager/pages/homePage.dart';
import 'package:expensemanager/provider.dart';
import 'package:expensemanager/services/auth_service.dart';
import 'package:expensemanager/settings_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
 
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomeController(),
        routes: {
          '/home' : (BuildContext context) => HomeController(),
          //'/signIn': (BuildContext context) => HomePage(),
          //'/signIn': (BuildContext context) => HomeController(),
          '/signUp' : (BuildContext context) => LoginSign(authFormType: AuthFormType.signUp,),
          '/signIn': (BuildContext context) => LoginSign(authFormType: AuthFormType.signIn,),
          //'/add' : (BuildContext context) => AddPage(),
          '/anonimouslySignIn' : (BuildContext context) => LoginSign(authFormType: AuthFormType.anonymousUser,), //no anonimous//
          '/add' : (BuildContext context) => AddPage(),
          '/settings' : (BuildContext context)=> Settings(),
          //'/converUser' : (BuildContext context) => LoginSign(authFormType: AuthFormType.convertUser,),
          //
        },
        onGenerateRoute: (settings) {
          // if (settings.name == '/detailsPage') {
          //   //String categoryName = settings.arguments;
          //   DetailsParams detailsParams = settings.arguments;
          //   return MaterialPageRoute(
          //     builder: (BuildContext context) => DetailsPage(
          //       detailsParams: detailsParams,
          //     ),
          //   );
          // }
          DetailsParams detailsParams = settings.arguments;
            return MaterialPageRoute(
              builder: (BuildContext context) => DetailsPage(
                detailsParams: detailsParams,
              ),
            );
        }
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  
  HomeController({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.authStatechanges,
      builder: (BuildContext context,AsyncSnapshot<String>snapshot){
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? HomePage() : FirstView();
        }else{
          return Center(
            child: CircularProgressIndicator()
          );
        }
      }
    );
  }

}
