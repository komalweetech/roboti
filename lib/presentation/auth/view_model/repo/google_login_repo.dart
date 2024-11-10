import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:roboti_app/presentation/auth/model/google_login_response.dart';

class GoogleLoginSerice {
  GoogleLoginSerice();
  Future<GoogleLoginResponse?> signInWithGoogle() async {
    // UserModel? user;
    String? clientId;
    if (Platform.isIOS) {
      clientId =
          "124684460884-5csvahfa1oubaa384kkshrps22ivh3a6.apps.googleusercontent.com";
    }
    final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: clientId);

    // try {
    // If the user has signedin with the device, he should signout in order to
    // signin from another device.
    if (await _googleSignIn.isSignedIn()) await _googleSignIn.signOut();

    // If not then register using firebase GoogleSignin
    final GoogleSignInAccount? userAuth = await _googleSignIn.signIn();

    // Add email to the firestore collection for future validation
    if (userAuth != null) {
      final GoogleSignInAuthentication auth =
          await _googleSignIn.currentUser!.authentication;

      OAuthCredential oAuth = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(oAuth);

      String? idToken = await credential.user!.getIdToken();

      // idToken.
      String? accessToken = credential.credential!.accessToken!;
      // print(idToken.toString());
      // print(accessToken.toString());
      // debugPrint(accessToken);
      return GoogleLoginResponse(
        accessToken: accessToken,
        idToken: idToken,
        fullName: userAuth.displayName!,
        email: userAuth.email,
      );
    }

    return null;
    // return null;
    // } catch (e) {
    //   return null;
    // }
  }
}
