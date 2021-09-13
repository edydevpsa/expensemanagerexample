//APPLE Authentication
  // Future signInWithApple()async{
  //   final AuthorizationResult result = await AppleSignIn.performRequests([
  //     AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName]),
  //   ]);

  //   switch (result.status) {
  //     case AuthorizationStatus.authorized:
  //       final AppleIdCredential _auth = result.credential;
  //       final OAuthProvider oAuthProvider = new OAuthProvider('apple.com');
  //       final AuthCredential credential = oAuthProvider.credential(
  //         idToken: String.fromCharCodes(_auth.identityToken),
  //         accessToken: String.fromCharCodes(_auth.authorizationCode),
  //       );
  //       await _firebaseAuth.signInWithCredential(credential);

  //       //Update the User Information
  //       if (_auth != null) {
  //         await _firebaseAuth.currentUser.updateProfile(
  //           displayName: '${_auth.fullName.givenName} ${_auth.fullName.familyName}'
  //         );
  //       }
  //       break;
  //     case AuthorizationStatus.cancelled:
  //       print('User Cancelled');
  //       break;
  //     case AuthorizationStatus.error:
  //       print('Sign In Falled ${result.error.localizedDescription}');
  //       break;    
  //     default:
  //   }
  // }