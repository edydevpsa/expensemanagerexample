import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> get authStatechanges => _firebaseAuth.authStateChanges().map((User user) => user?.uid);
  
  //Get UID
  Future<String>getCurrentUID()async{
    String uid = _firebaseAuth.currentUser.uid;
    return uid;
  }
  //Email & Password Sign Up
  Future<String>createUserWithEmailandPassword(String email, String password, String name)async{
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    //Update User and Profile
    updateUserandProfile(name, authResult.user);
    return authResult.user.uid;
  }

  //Function Update tha User Name and Profile
  Future updateUserandProfile(String name, User currentuser)async{
    await currentuser.updateProfile(displayName: name);
    await currentuser.reload();
  }

  //Email and Password Sign In
  Future<String>signInWitnEmailandPassword(String email, String password)async{

    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user.uid;
  }

  //Sign Out
  signOut(){
    return _firebaseAuth.signOut();
  }

  //reset Password
  Future sendpasswordResetEmail(String email)async{
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Create anonimous user
  Future signInAnonimously()async{
    return  await _firebaseAuth.signInAnonymously();
  }
   
  //GOOGLE SIGN IN 
  Future<String>signInWithGoogle()async{
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleSignInAuth = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleSignInAuth.idToken, accessToken: _googleSignInAuth.accessToken
    );
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;

  }

  //APPLE Sign In
  // Future signInWithApple()async{
  //   final AuthorizationResult result = await AppleSignIn.performRequests([
  //     AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName,]),
  //   ]);

  //   switch (result.status) {
  //     case AuthorizationStatus.authorized:
  //       final AppleIdCredential _appleCredential = result.credential;
  //       final OAuthProvider oAuthProvider = new OAuthProvider("apple.com");
  //       final AuthCredential credential = oAuthProvider.credential(
  //         idToken: String.fromCharCodes(_appleCredential.identityToken),
  //         accessToken: String.fromCharCodes(_appleCredential.authorizationCode),
  //       );

  //       await _firebaseAuth.signInWithCredential(credential);

  //       //Update the User Information
  //       if (_appleCredential != null) {
  //         await _firebaseAuth.currentUser.updateProfile(
  //           displayName: "${_appleCredential.fullName.givenName} ${_appleCredential.fullName.familyName}"
  //         );
  //       }
  //       break;

  //     case AuthorizationStatus.cancelled:
  //       print('Apple SingIn User Cancelled');
  //       break;

  //     case AuthorizationStatus.error:
  //       print("Sing In Failed ${result.error.localizedDescription}");
       
  //       break;
  //     default:
  //   }
  // }

  ////APPLE SIGN IN 2
  // Future<bool> get isAvailable(){
  //   return SignInWithApple.isAvailable();
  // }
  /// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  final charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<UserCredential> signInWithApple() async {
  // To prevent replay attacks with the credential returned from Apple, we
  // include a nonce in the credential request. When signing in with
  // Firebase, the nonce in the id token returned by Apple, is expected to
  // match the sha256 hash of `rawNonce`.
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);

  // Request credential for the currently signed in Apple account.
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: nonce,
  );

  // Create an `OAuthCredential` from the credential returned by Apple.
  final oauthCredential = OAuthProvider("apple.com").credential(
    idToken: appleCredential.identityToken,
    rawNonce: rawNonce,
  );

  // Sign in the user with Firebase. If the nonce we generated earlier does
  // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  return await _firebaseAuth.signInWithCredential(oauthCredential);
}
}

class NameValidator {
  static String validate(String value){
    if (value.isEmpty) {
      return ' Your Name can\'t be empty';
    }
    if (value.length < 2) {
      return ' Name must be at least 2 characters long';
    }
    if (value.length > 50) {
      return ' Name must be less than 50 characters long';
    }

    return null;
  }
}

class EmailValidator {
  static String validate(String value){
    if (value.isEmpty) {
      return 'Email can\'t be empty';
    }
    return null;
  }
}
class PasswordValidator {
  static String validate(String value){
    if (value.isEmpty) {
      return 'Password can\'t be empty';
    }
    return null;
  }
}